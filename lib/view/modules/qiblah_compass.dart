
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:khushoo3/view/modules/qibla.dart';
import 'package:khushoo3/view_model/qibla_VM.dart';
import 'package:khushoo3/view_model/states.dart';

import 'package:khushoo3/l10n/generated/app_localizations.dart';

import 'loading_indicator.dart';
import 'location_error_widget.dart';

qiblaVM? VM;

class getQibla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocProvider(
      create: (BuildContext context) => qiblaVM()
        ..startcombass()
        ..checkLocationStatus(),
      child: BlocConsumer<qiblaVM, BaseStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          VM = qiblaVM.get(context);
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              stream: VM!.locationStreamController!.stream,
              builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return LoadingIndicator();
                if (snapshot.data!.enabled == true) {
                  switch (snapshot.data!.status) {
                    case LocationPermission.always:
                    case LocationPermission.whileInUse:
                      return QiblahCompassWidget();

                    case LocationPermission.denied:
                      Fluttertoast.showToast(
                          msg: l10n?.locationPermissionRequired ?? "يجب السماح للتطبيق بالوصول للموقع ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      return LocationErrorWidget(
                        error: l10n?.locationDenied ?? "تم رفض الوصول للموقع",
                        callback: VM!.checkLocationStatus,
                      );
                    case LocationPermission.deniedForever:
                      return LocationErrorWidget(
                        error: l10n?.locationDeniedForever ?? "تم رفض الوصول للموقع الي الابد ",
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
                    callback: VM!.checkLocationStatus,
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
