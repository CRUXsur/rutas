import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas/blocs/blocs.dart';
import 'package:rutas/screens/screens.dart';
import 'package:rutas/services/services.dart';

//void main() => runApp(const RutasApp());

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(
            create: (context) =>
                MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
        BlocProvider(
            create: (context) => SearchBloc(trafficService: TrafficService())),
      ],
      child: const RutasApp(),
    ),
  );
}

class RutasApp extends StatelessWidget {
  const RutasApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RutasApp',
      home: LoadingScreen(),
    );
  }
}
