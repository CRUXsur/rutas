part of 'gps_bloc.dart';

//abstract class GpsState extends Equatable {
class GpsState extends Equatable {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  //es decir que cuando hagamos un cambio de estado, que el estado cambia
  //va a revisar y evaluar nuevamente este getter, este(isAllGranted) va
  // a ser true: si y solo si ambos permisos estan en true
  //true ^ true = true
  //true ^ false = false .....

  //!me creo un getter,que me diga si todo esta bien
  //!o alguno de los dos esta mal....
  //! si los dos true => isAllGranted es true
  //! si un de los dos es false = > isAllGranted es false
  bool get isAllGranted => isGpsEnabled && isGpsPermissionGranted;

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
