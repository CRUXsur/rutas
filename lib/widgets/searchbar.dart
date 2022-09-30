import 'package:flutter/material.dart';

import 'package:rutas/delegates/delegates.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        //color: Colors.red,
        width: double.infinity,
        //height: 50,
        child: GestureDetector(
          onTap: () {
            //print('ontap');
            showSearch(context: context, delegate: SearchDestinationDelegate());
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))
              ],
            ),
            child: const Text('¿Dónde quieres ir?',
                style: TextStyle(color: Colors.black87)),
          ),
        ),
      ),
    );
  }
}
