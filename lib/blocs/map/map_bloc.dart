import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:rutas/blocs/blocs.dart';
import 'package:rutas/models/models.dart';
import 'package:rutas/themes/themes.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart' show GoogleMapController, LatLng;

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  //no le pongo ? opcional, porque es obligatorio
  //final LocationBloc? locationBloc;

  //Estoy obligando a que para que se cree una nueva instancia de mi mapBloc
  //necesito la instancia de el locationBloc

  final LocationBloc locationBloc; //es obligatorio

  GoogleMapController? _mapController;
  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({
    required this.locationBloc,
  }) : super(const MapState()) {
    //on<OnMapInitializedEvent>((event, emit) => emit(state.copyWith(isMapInitialized: true)));
    on<OnMapInitializedEvent>(_onInitMap);

    //
    // on<OnStartFollowingUserEvent>(
    //     (event, emit) => emit(state.copyWith(isFollowingUser: true)));
    on<OnStartFollowingUserEvent>(_onStartFollowingUser);

    on<OnStopFollowingUserEvent>(
        (event, emit) => emit(state.copyWith(isFollowingUser: false)));

    //polylines
    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);
    on<OnToggleUserRoute>(
        (event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));

    on<DisplayPolylinesEvent>(
        (event, emit) => emit(state.copyWith(polylines: event.polylines)));

    //tengo que estar escuchando los cambios en el stream!
    //=>necesito suscribirme y esta es nuestra subcription....
    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnownLocation != null) {
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }
      //stream necesito limpiarlo!
      //necesito saber si necesito mover la camara,
      //para mover la camara,primero tengo que saber varias cosas,
      //por ejemplo, si en el state.followUser del mapBloc , no esta
      //siguiendo al usuario => no hago nada aqui!
      if (!state.isFollowingUser) return;
      //else
      //verifico si en el LocationState, tenemos el lastKnownLocation
      if (locationState.lastKnownLocation == null) return;

      // else move camera
      //y ! porque ya verifique que si existe!
      moveCamera(locationState.lastKnownLocation!);
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

  //OPTIMIZACION!!! 19.218
  void _onStartFollowingUser(
      OnStartFollowingUserEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUser: true));
    if (locationBloc.state.lastKnownLocation == null) return;
    moveCamera(locationBloc.state.lastKnownLocation!);
  }

  void _onPolylineNewPoint(
      UpdateUserPolylineEvent event, Emitter<MapState> emit) {
    //me creo la polyline , que es la linea que  yo quiero manejar
    //
    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations,
    );

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;
    //myRoute es lo que tengo que mandar al state
    emit(state.copyWith(polylines: currentPolylines));
  }

  Future drawRoutePolyline(RouteDestination destination) async {
    //creo mi ruta, polyline
    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 5,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );

    final curretPolylines = Map<String, Polyline>.from(state.polylines);
    curretPolylines['route'] = myRoute;

    //emito ese evento
    add(DisplayPolylinesEvent(curretPolylines));
  }

  //nos creamos un evento, de tal manera que nos pueda servir esto
  //en cualquier momento para mover el mapa en cualquier lado de
  //nuestra apliacacion

  //Rx LatLng posicionDondeQuieroQueSeVaya
  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
