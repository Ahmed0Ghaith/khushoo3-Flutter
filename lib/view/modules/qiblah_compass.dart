import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:khushoo3/view/modules/qibla.dart';
import 'package:khushoo3/view_model/qibla_VM.dart';
import 'package:khushoo3/view_model/states.dart';

import 'loading_indicator.dart';
import 'location_error_widget.dart';
qiblaVM ?VM;
class getQibla extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (BuildContext context)=>qiblaVM()
      ..startcombass()
        ..checkLocationStatus()
      ,
      child: BlocConsumer <qiblaVM,BaseStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context,  state) {
          VM=qiblaVM.get(context);
       return  Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              stream: VM!.locationStreamController!.stream
              ,
              builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return LoadingIndicator();
                if (snapshot.data!.enabled == true) {
                  switch (snapshot.data!.status) {
                    case LocationPermission.always:
                    case LocationPermission.whileInUse:
                      return QiblahCompassWidget();

                    case LocationPermission.denied:
                      return LocationErrorWidget(
                        error: "تم رفض الوصول للموقع",
                        callback: VM!.checkLocationStatus,
                      );
                    case LocationPermission.deniedForever:
                      return LocationErrorWidget(
                        error: "تم رفض الوصول للموقع الي الابد ",
                        callback: VM!.checkLocationStatus,
                      );
                  // case GeolocationStatus.unknown:
                  //   return LocationErrorWidget(
                  //     error: "Unknown Location service error",
                  //     callback: _checkLocationStatus,
                  //   );
                    default:
                      return Container();
                  }
                } else {
                  return LocationErrorWidget(
                    error: "من فضلك قم بتفعيل الحصول الموقع",
                    callback:VM!.checkLocationStatus,
                  );
                }
              },
            ),
          );

        },
      ),
    );

  }


}
