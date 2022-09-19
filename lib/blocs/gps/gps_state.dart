part of 'gps_bloc.dart';

//abstract class GpsState extends Equatable {
class GpsState extends Equatable {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  // creo un eventoEstado (GpsState) para manejar ambos: isGpsEnabled y isGpsPermissionGranted
  //llaves: por que quiero que sea por nombre
  const GpsState({
    required this.isGpsEnabled,
    required this.isGpsPermissionGranted,
  });

  //copyWith: para no perder valores! del estado actual
  GpsState copyWith({
    //todas propiedades que se quiere manejar en el estado
    // ?: opcionales
    bool? isGpsEnabled,
    bool? isGpsPermissionGranted,
  }) =>
      GpsState(
        // : Si viene un valor, => usa ese valor!
        // ?? si no, usa el valor que tebgamos en el state
        isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
        isGpsPermissionGranted:
            isGpsPermissionGranted ?? this.isGpsPermissionGranted,
      );

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGranted];

  //Sobre escribo este metodo para el //print('state: $state');
  @override
  String toString() =>
      '{isGpsEnabled: $isGpsEnabled,isGpsPermissionGranted: $isGpsPermissionGranted}';
}
