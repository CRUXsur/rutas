import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas/blocs/blocs.dart';
import 'package:rutas/helpers/helpers.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const _ManualMarkerBody()
            : const SizedBox();

        // if (state.displayManualMarker) {
        //   return const _ManualMarkerBody();
        // } else {
        //   return const SizedBox();
        // }
        //
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          //
          const Positioned(
            top: 70,
            left: 20,
            child: _BtnBack(),
          ),
          //
          Center(
            child: Transform.translate(
              offset: const Offset(0, -22),
              child: BounceInDown(
                from: 100,
                child: const Icon(Icons.location_on_rounded, size: 60),
              ),
            ),
          ),
          //Boton de confirmar
          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              duration: const Duration(milliseconds: 300),
              child: MaterialButton(
                minWidth: size.width - 120,
                color: Colors.black,
                elevation: 0,
                height: 50,
                shape: const StadiumBorder(),
                onPressed: () async {
                  // Todo: loading
                  //Done: confirmar ubicacion.....
                  final start = locationBloc.state.lastKnownLocation;
                  if (start == null) return; //una regla de validacion....
                  //print(start);
                  final end = mapBloc.mapCenter;
                  if (end == null) return; //una regla de validacion....
                  //print(end);

                  //como ya tengo el start y el end, pongo mi loading message
                  showLoadingMessage(context);

                  final destination =
                      await searchBloc.getCoorsStartToEnd(start, end);
                  await mapBloc.drawRoutePolyline(destination);

                  //
                  //quitamos la barra boton y el icono <
                  searchBloc.add(OnDeactivateManualMarkerEvent());
                  //
                  Navigator.pop(context);
                },
                child: const Text(
                  'Confirmar destino',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            //DoneTODO: Cancelar el marcador manual
            BlocProvider.of<SearchBloc>(context).add(
              OnDeactivateManualMarkerEvent(),
            );
          },
        ),
      ),
    );
  }
}
