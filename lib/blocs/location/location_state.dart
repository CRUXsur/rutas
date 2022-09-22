part of 'location_bloc.dart';

//abstract class LocationState extends Equatable {
//* solo tengo una clase para manejar mi estado...
//*extiende de Equatable, porque necesito poder
//*hacer comparaciones de estado despues
//*especialmente para la parte de bloc

class LocationState extends Equatable {
  //*eventualmente yo necesito saber, si yo estoy siguiendo
  //*al usuario..
  final bool followingUser;
  // Done 2 TODO! TODO
  //* 1.- cual fue su ultima ubicacion conocida
  //* o su ultimo geolocation conocido
  //* 2.- y la historia de las ultimas ubicaciones

  const LocationState({
    //*required this.followingUser,
    //*por defecto, no quiero que lo este siguiendo
    this.followingUser = false,
  });

  @override
  List<Object> get props => [followingUser];
}
