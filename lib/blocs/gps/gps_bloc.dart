import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

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
    //lo ponemos en el constructor, inicia el geolocator
    _init();
  }

  //me creo unos metodos que me permitan inicializar el servicio
  //o inicializar el stream de informacion que va a venir
  //proviniente del geolocator

  //inicializacion:
  Future<void> _init() async {
    //!Future disparados de forma separada
    final isEnabled = await _checkGpsStatus();
    print('isEnabled: $isEnabled');
  }

  //tenemos un listener que esta pendiente de cualquier cambio
  //del servicio de GPS; pero es buena practica, que cuando se haga
  //un listener, tenemos que limpiar ese listener, aunque este servicio
  //o este bloc, nunca se va a cancelar, siempre esta pendiente de toda
  //aplicacion siempre es bueno limpiarlo para evitar fugas de memoria
  //
  Future<bool> _checkGpsStatus() async {
    //!aqui es cuando se inicializa se carga app y se si esta o no esta
    //!habilitado
    final isEnable = await Geolocator.isLocationServiceEnabled();
    Geolocator.getServiceStatusStream().listen((event) {
      // !En este punto es cuando el servicio cambia!, habilito o deshabilitado
      print('service status $event');
      // !pone un uno o cero si en cualquier momento se habilita o deshabilita
      // !el servicio, tendre que estar pendiente de los cambios, disparar eventos
      final isEnabled = (event.index == 1) ? true : false;
      print('service status $isEnabled');
    });
    return isEnable;
  }

  //close se llama cuando el bloc ya no se va a utilizar o se va a
  //deshechar
  @override
  Future<void> close() {
    //TODO: limpiar el ServiceStatus stream
    return super.close();
  }
}
