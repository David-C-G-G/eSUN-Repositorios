// part of 'repositorio_form_cubit.dart';

// class RepositorioFormState extends Equatable {

//   final bool isFormValid;
//   final String? id;
//   final Title title;
//   final Docente docente;
//   final Materia materia;
//   final TipoTrabajo tt;
//   final int seccion;
//   final String? anotacion;
//   final String? comentario;
//   final List<String>? archivoComprimido;

//   const RepositorioFormState({
//     this.isFormValid = false, 
//     this.id, 
//     this.title = const Title.dirty(''), 
//     this.docente = const Docente.dirty(''), 
//     this.materia = const Materia.dirty(''), 
//     this.tt = const TipoTrabajo.dirty(''), 
//     this.seccion = 0, 
//     this.anotacion = '', 
//     this.comentario = '', 
//     this.archivoComprimido = const [], 
//   });

//   RepositorioFormState copyWith({
//     bool? isFormValid,
//     String? id,
//     Title? title,
//     Docente? docente,
//     Materia? materia,
//     TipoTrabajo? tt,
//     int? seccion,
//     String? anotacion,
//     String? comentario,
//     List<String>? archivoComprimido,
//   }) => RepositorioFormState(
//     isFormValid: isFormValid ?? this.isFormValid,
//     id: id ?? this.id,
//     title: title ?? this.title,
//     docente: docente ?? this.docente,
//     materia: materia ?? this.materia,
//     tt: tt ?? this.tt,
//     seccion: seccion ?? this.seccion,
//     anotacion: anotacion ?? this.anotacion,
//     comentario: comentario ?? this.comentario,
//     archivoComprimido: archivoComprimido ?? this.archivoComprimido,
//   );

//   @override
//   List<Object?> get props => [
//     isFormValid,
//     id,
//     title,
//     docente,
//     materia,
//     tt,
//     seccion,
//     anotacion,
//     comentario,
//     archivoComprimido,
//   ];
// }
