import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas/blocs/blocs.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart' show GoogleMapController, LatLng;
import '../../themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  //no le pongo ? opcional, porque es obligatorio
  //final LocationBloc? locationBloc;
  final LocationBloc locationBloc; //es obligatorio

  GoogleMapController? _mapController;

  MapBloc({
    required this.locationBloc,
  }) : super(const MapState()) {
    //on<OnMapInitializedEvent>((event, emit) => emit(state.copyWith(isMapInitialized: true)));
    on<OnMapInitializedEvent>(_onInitMap);

    //tengo que estar escuchando los cambios en el stream!
    //=>necesito suscribirme y esta es nuestra subcription....
    locationBloc.stream.listen((LocationState) {
      //stream necesito limpiarlo!
      //necesito saber si necesito mover la camara,
      //para mover la camara,primero tengo que saber varias cosas,
      //por ejemplo, si en el state.followUser del mapBloc , no esta
      //siguiendo al usuario => no hago nada aqui!
      if (!state.isFollowingUser) return;
      //else
      //verifico si en el LocationState, tenemos el lastKnownLocation
      if (LocationState.lastKnownLocation == null) return;

      // else move camera
      //y ! porque ya verifique que si existe!
      moveCamera(LocationState.lastKnownLocation!);
    });
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller; //aqui se esta asignando _mapController
    //*_mapController. aqui tengo muchas cosas.....
    //
    //*cambio el theme: de uber from https://snazzymaps.com/style/90982/uber-2017
    _mapController!.setMapStyle(jsonEncode(uberMapTheme));

    emit(state.copyWith(isMapInitialized: true));
  }

  //nos creamos un evento, de tal manera que nos pueda servir esto
  //en cualquier momento para mover el mapa en cualquier lado de
  //nuestra apliacacion

  //Rx LatLng posicionDondeQuieroQueSeVaya
  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }
}
