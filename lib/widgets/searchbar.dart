import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas/blocs/blocs.dart';

import 'package:rutas/delegates/delegates.dart';
import 'package:rutas/models/models.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const SizedBox()
            : FadeInDown(
                //BounceInDown or ElasticInDown
                duration: const Duration(milliseconds: 300),
                child: const _SearchBarBody(),
              );
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody();

  void onSearchResults(BuildContext context, SearchResult result) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    //
    if (result.manual == true) {
      //mando a llamar a mi BlocProvider, para buscar mi SearchBloc
      //y mandar el evento que yo necesito
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }
  }

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
          onTap: () async {
            //print('ontap');
            final result = await showSearch(
                context: context, delegate: SearchDestinationDelegate());
            if (result == null) return;

            // print(result);
            onSearchResults(context, result);
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
