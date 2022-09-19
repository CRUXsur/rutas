import 'package:flutter/material.dart';
import 'package:rutas/screens/screens.dart';

void main() => runApp(const RutasApp());

class RutasApp extends StatelessWidget {
  const RutasApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RutasApp',
      home: GpsAccessScreen(),
    );
  }
}
