part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

//! en los eventos me creo un nuevo evento que me permita a mi,
//! recibir una nueva ubicacion, esa nueva ubicacion va a
//! ubicarse en   final LatLng? lastKnownLocation; y tb referirse a
//!  final List<LatLng> myLocationHistory

class OnNewUserLocationEvent extends LocationEvent {
  //! necesito recibir algo de tipo LatLng y se llamara newlocation
  // ignore: prefer_typing_uninitialized_variables
  final LatLng newLocation;

  //! lo dejo posicional, porque solo voy a recibir una nueva ubicacion
  //! no me deja para nada complicado dejarlo posicional, (this.newLocation)
  //! este mi nuevo evento lo tengo que manejar en mi location_bloc.....
  //! con llaves ({this.newLocation}), seria por nombre!
  const OnNewUserLocationEvent(this.newLocation);
}

//! disparamos estos eventos para saber si esta o no siguendo al user!
//!   OnStartFollowingUser
//!   OnStopFollowingUser

//! luego nos creamos los manejadores de este cambio en nuestro estado
//! vamos a manejar estos eventos

class OnStartFollowingUser extends LocationEvent {
  //
}

class OnStopFollowingUser extends LocationEvent {
  //
}
