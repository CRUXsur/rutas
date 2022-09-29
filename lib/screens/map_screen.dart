import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:rutas/blocs/blocs.dart';
import 'package:rutas/views/views.dart';
import 'package:rutas/widgets/btn_toggle_user_route.dart';
import 'package:rutas/widgets/widgets.dart';

//? convierto de statelesws a statefulw,
//? mas que todo porque quiero tener el initState
//? que solo se dispara una vez cuando este widget se
//? construye y cuando
class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //!inicializo
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();

    //? uso este initstate, para tener acceso a mi bloc location
    //locationBloc.getCurrentPosition();
    //!final locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    //!ya no necesito esta linea, las tengo arriba
    //!final locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          //si no tenemos inguna ubicacion regresamos...
          if (locationState.lastKnownLocation == null) {
            return const Center(child: Text('Espere por favor...'));
          }
          //
          // return Center(
          //   child: Text(
          //       '${state.lastKnownLocation!.latitude},${state.lastKnownLocation!.longitude}'),
          // );
          //
          // final CameraPosition initialCameraPosition = CameraPosition(
          //   target: state.lastKnownLocation!,
          //   zoom: 15,
          // );
          //return GoogleMap(initialCameraPosition: initialCameraPosition);
          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              //me creo un objeto
              Map<String, Polyline> polylines = Map.from(mapState.polylines);
              if (!mapState.showMyRoute) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      initialLocation: locationState.lastKnownLocation!,
                      polylines: polylines.values.toSet(),
                    ),
                    // TODO: botones y mas cosas!........
                    const SearchBar(),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnToggleUserRoute(),
          BtnFollowUser(),
          BtnCurrentLocation(),
        ],
      ),
    );
  }
}
