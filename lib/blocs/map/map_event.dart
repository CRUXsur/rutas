part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  //*controlador que va a generarme el mapa, de tipo GoogleMapController
  final GoogleMapController controller;

  const OnMapInitializedEvent(this.controller); //constructor posicional
}

class OnStopFollowingUserEvent extends MapEvent {}

class OnStartFollowingUserEvent extends MapEvent {}
