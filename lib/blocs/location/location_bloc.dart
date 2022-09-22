import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  //*ya no tenemos LocationInitial(), solo tenemos LocationState
  //*LocationBloc() : super(LocationInitial()) {
  LocationBloc() : super(const LocationState()) {
    on<LocationEvent>((event, emit) {});
  }

  //?creo dos metodos, para seguir la ubicacion del usuario

  //? me obtiene la posicion actual de usuario
  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    print('Position: $position');
  }

  //?empezar a darle seguimiento al usuario
  void startFollowingUser() {
    Geolocator.getPositionStream().listen((event) {
      final position = event;
      print('Position: $position');
    });
  }
}
