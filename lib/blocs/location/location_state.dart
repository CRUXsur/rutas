part of 'location_bloc.dart';

//abstract class LocationState extends Equatable {
//* solo tengo una clase para manejar mi estado...
//*extiende de Equatable, porque necesito poder
//*hacer comparaciones de estado despues
//*especialmente para la parte de bloc

class LocationState extends Equatable {
  //*eventualmente yo necesito saber, si yo estoy siguiendo
  //*al usuario..
  final bool isFollowingUser;
  // Done 2 todoo!
  //* 1.- cual fue su ultima ubicacion conocida
  //* o su ultimo geolocation conocido
  //* 2.- y la historia de las ultimas ubicaciones
  final LatLng? lastKnownLocation;
  final List<LatLng> myLocationHistory;

  const LocationState({
    //*required this.followingUser,
    //*por defecto, no quiero que lo este siguiendo
    this.isFollowingUser = false,
    this.lastKnownLocation,
    myLocationHistory,
  }) : myLocationHistory = myLocationHistory ?? const [];

  //!me creo el copywith, que regresa un nuevo LocationState
  LocationState copyWith({
    //definimos cada uno de los valores posibles que recibimos aca!
    //en este caso son tres!!!!
    bool? isFollowingUser,
    LatLng? lastKnownLocation,
    List<LatLng>? myLocationHistory,
  }) =>
      //despues regreasmos un nuevo LocationSate()....
      LocationState(
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
        myLocationHistory: myLocationHistory ?? this.myLocationHistory,
      );

  //*este @override viene del Equatable
  //*lo pongo aqui el followingUser, para que inclusive
  //* flutter bloc, pueda saber cuando hay un cambio del state
  //!por el lastKnownLocation que son opcionales, entonces
  //!List<Object> lo hago opcional List<Object?>
  @override
  List<Object?> get props =>
      [isFollowingUser, lastKnownLocation, myLocationHistory];
}
