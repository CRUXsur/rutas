import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas/ui/ui.dart';

import 'package:rutas/blocs/blocs.dart';

class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.my_location_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            //DONE: Llamar el bloc
            final userLocation = locationBloc.state.lastKnownLocation;

            //la ultima ubicacion puede ser nula....
            //SnackBar REUTILIZABLES, PERSONALIZADOS!!
            if (userLocation == null) {
              final snack = CustomSnackbar(message: 'No hay ubicacion');
              ScaffoldMessenger.of(context).showSnackBar(snack);
              return;
            }
            //Done: SnackBar
            mapBloc.moveCamera(userLocation);
          },
        ),
      ),
    );
  }
}
