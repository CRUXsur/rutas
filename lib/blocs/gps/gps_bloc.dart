import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc()
      : super(
          //estado incial de nuestro Bloc
          const GpsState(isGpsEnabled: false, isGpsPermissionGranted: false),
        ) {
    //cuando recibo ese evento, yo emito un nuevo estado
    //en funcion de flecha
    //pensar que voy a hacer cuando reciba un evento de tipo(GpsAndPermissionEvent)
    on<GpsAndPermissionEvent>(
      (event, emit) => emit(state.copyWith(
        //emito un nuevo estado
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted,
      )),
    );
  }
}
