part of 'map_bloc.dart';

//estrategia que es:
//  de NO tener una clase abstracta
//  sino es solo tener un tipo de estado
//  hacer el copywith.....
class MapState extends Equatable {
  //*ya esta el mapa cargado?, si ya tengo accceso a el?
  //*ya puedo usarlo?
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showMyRoute;

  //Polylines
  final Map<String, Polyline> polylines;
  /*
    'mi_ruta: {
      id: polylineID Google
      points: [[lat,lng],[1234,1234],[12345,1234553]]
      width:3
      color:black.87
    }
  */
  const MapState({
    // required this.isMapInitialized,
    // required this.followUser,
    // como los inicializo => ya no required!!!!
    this.isMapInitialized = false,
    this.isFollowingUser = true, //por defecto
    this.showMyRoute = true,
    Map<String, Polyline>? polylines, //recibo polylines opcionales
  }) : polylines = polylines ?? const {};

  MapState copyWith(
          {
          //copiamos el listado de propiedades, para generar unas nuevas
          //son opcionales: ? pueda ser que las reciba, pueda ser que no!
          bool? isMapInitialized,
          bool? isFollowingUser,
          bool? showMyRoute,
          Map<String, Polyline>? polylines}) =>
      MapState(
        //a la hora de crear un nuevo estado...MapState
        //sera igual a esas propiedades o el valor que tenga el estado...
        //en nuestra instancia actual
        //*inicializamos con valores...
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        showMyRoute: showMyRoute ?? this.showMyRoute,
        polylines: polylines ?? this.polylines,
      );

  // como tengo dos propiedaes y eventualmente mi Bloc, necesita saber
  // cuando un estado es diferente a otro......entonces esas dos propiedades
  // la coloco en las props....props => [isMapInitialized, followUser];
  @override
  List<Object> get props =>
      [isMapInitialized, isFollowingUser, showMyRoute, polylines];
}
