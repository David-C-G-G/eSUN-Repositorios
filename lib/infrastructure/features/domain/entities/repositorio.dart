

import 'package:esun/domain/domain.dart';

class Repositorio {
  String id;
  String title;
  String docente;
  String materia;
  int seccion;
  String? anotacion;
  String? comentario;
  // String cu;
  String tt;
  List<String> archivoComprimido;
  User? user;

  Repositorio({
    required this.id,
    required this.title,
    required this.docente,
    required this.materia,
    required this.seccion,
    required this.anotacion,
    required this.comentario,
    // required this.cu,
    required this.tt,
    required this.archivoComprimido,
    required this.user,
  });

}
