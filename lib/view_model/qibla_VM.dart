import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:khushoo3/view_model/states.dart';

class qiblaVM extends Cubit<BaseStates>
{
  qiblaVM() : super(InitialState());
  String?  statetext ;


  StreamController<LocationStatus>? locationStreamController;

  static qiblaVM get(context) => BlocProvider.of(context);

  startcombass()
  {
    try
        {
           locationStreamController =
          StreamController<LocationStatus>.broadcast();
         locationStreamController!.stream;

        }
        catch(ex)
    {

    }
  }

  Future<void> checkLocationStatus() async {

    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {

      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      locationStreamController!.sink.add(s);
      emit(GetGeoLocatorPermission());
    } else
      locationStreamController!.sink.add(locationStatus);
    emit(SucessLocatorPermission());
  }

  void dispose() {

    locationStreamController!.close();
    FlutterQiblah().dispose();
  }

}