import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

//RouteDestination este es mi modelo para la respuesta que
class RouteDestination {
  //
  final List<LatLng> points;
  final double duration;
  final double distance;

  RouteDestination({
    required this.points,
    required this.duration,
    required this.distance,
  });
}
