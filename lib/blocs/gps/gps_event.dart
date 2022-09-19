part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

//creo un evento para manejar ambos:isGpsEnabled, isGpsPermissionGranted
//Este es el evento (GpsAndPermissionEvent) que va a modificar mi estado
class GpsAndPermissionEvent extends GpsEvent {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  //Constructor
  const GpsAndPermissionEvent({
    required this.isGpsEnabled,
    required this.isGpsPermissionGranted,
  });
}
//--------