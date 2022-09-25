import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsServiceSubscription;

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
    //final isEnabled = await _checkGpsStatus();
    //final isGranted = await _isPermissionGranted();
    //print('isEnabled: $isEnabled,isGranted: $isGranted');
    //!Futures, promesas disparadas de manera simultanea!
    //!gpsInitStatus: regresamos una lista de booleanos!
    final gpsInitStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);
    //add(GpsAndPermissionEvent(
    //  isGpsEnabled: isEnabled, //el estado del GPS es isEnable!
    //  //isGpsPermissionGranted: state.isGpsPermissionGranted, //es estado actual!
    //  isGpsPermissionGranted: isGranted, //es estado actual!
    //));
    add(GpsAndPermissionEvent(
      isGpsEnabled: gpsInitStatus[0],
      isGpsPermissionGranted: gpsInitStatus[1],
    ));
  }

  //* me creo un nuevo metodo
  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted; //regresa un true or false!
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
    //! esta es mi subscripcion
    gpsServiceSubscription =
        Geolocator.getServiceStatusStream().listen((event) {
      // !En este punto es cuando el servicio cambia!, habilito o deshabilitado
      //print('service status $event');
      // !pone un uno o cero si en cualquier momento se habilita o deshabilita
      // !el servicio, tendre que estar pendiente de los cambios, disparar eventos
      final isEnabled = (event.index == 1) ? true : false;
      //print('service status $isEnabled');
      add(GpsAndPermissionEvent(
        isGpsEnabled: isEnabled, //el estado del GPS es isEnable!
        isGpsPermissionGranted:
            state.isGpsPermissionGranted, //es estado actual!
      ));
    });
    return isEnable;
  }

  // Logica para cuando el usuario pulsa el boton 'Solicitar Acceso'
  // solicitando permiso al GPS y a la localizacion
  Future<void> askGpsAccess() async {
    // pedir permiso al mismo
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled,
            isGpsPermissionGranted: true)); //i can work with GPS!
        break;
      //todos los demas are false!
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled,
            isGpsPermissionGranted: false)); //i can not work with GPS!
        //no puedo hacer nada...open la settings! del celular
        //es un metodo que esta en el paquete(permission_handler)
        openAppSettings();
    }
  }

  //close se llama cuando el bloc ya no se va a utilizar o se va a
  //deshechar
  @override
  Future<void> close() {
    //DONE: limpiar el ServiceStatus stream
    //? ? :si tienes un valor cancelalo, sino no tienes nada que cancelar
    //? no lo hagas
    gpsServiceSubscription?.cancel();
    return super.close();
  }
}
