import 'package:animate_do/animate_do.dart';
import 'package:esun/presentacion/widgets.dart';
import 'package:flutter/material.dart';

const cards = <String> [

  'Hola',
  'Saludos',
  '¿como estas?',
  'buenos dias',
  'buenas tardes',
  'buenas noches',
  'que tal',
  'wey',
  'que onda',
  'tanto tiempo',
  'estas ocupado(a)',
  'bien',
  'mal',
  'mas o menos',
  'ahi voy',
  'ya mero',

];

// typedef SearchDocentesCallback = List<String> Function(String query);

class SearchDocenteDelegate extends SearchDelegate<String?> {

  // final SearchDocentesCallback searchDocente;

  // SearchDocenteDelegate({
    // required this.searchDocente //TODO: quedó pendiende
  // });

  @override
  String get searchFieldLabel => 'Buscar Docente';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
        FadeIn(
          animate: query.isNotEmpty,
          duration: const Duration(milliseconds: 100),
          child: CustomButtonImage(
          onTap: () => query = '',
          name: 'assets/borrar.png'
          ),
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null), 
      icon: const CustomButtonImage(name: 'assets/regresar.png')
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text('Build Suggestions');
  }



}

