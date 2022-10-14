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

class UpdateUserPolylineEvent extends MapEvent {
  //aqui yo voy a ocupar la historia, todos los polylines
  //todas las ubicaciones del usuario
  final List<LatLng> userLocations;
  const UpdateUserPolylineEvent(this.userLocations);
}

//ara sohwMyRoutes me creo un toggle!
class OnToggleUserRoute extends MapEvent {}

class DisplayPolylinesEvent extends MapEvent {
  final Map<String, Polyline> polylines;
  const DisplayPolylinesEvent(this.polylines);
}
