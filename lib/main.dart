import 'package:flutter/material.dart';

void main() => runApp(const RutasApp());

class RutasApp extends StatelessWidget {
  const RutasApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RutasApp',
        home: Scaffold(
          body: Center(
            child: Text("RUTAS APP"),
          ),
        ));
  }
}
