import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rutas/blocs/blocs.dart';

class BtnFollowUser extends StatelessWidget {
  const BtnFollowUser({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: BlocBuilder<MapBloc, MapState>(
          //estoy escuchando el MapBloc
          builder: (context, state) {
            return IconButton(
              icon: Icon(
                state.isFollowingUser
                    ? Icons.directions_run_rounded
                    : Icons.hail_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                //lo unico que necesita es disparar el FollowUser
                //or podemos hacerlo como un toggle!
                mapBloc.add(OnStartFollowingUserEvent());
              },
            );
          },
        ),
      ),
    );
  }
}
