
import 'package:esun/config/config.dart';
import 'package:esun/presentacion/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import 'package:esun/infrastructure/inputs.dart';
import '../../../infrastructure/features/domain/domain.dart';


final repositorioFormProvider = StateNotifierProvider.autoDispose.family<RepositorioFormNotifier,RepositorioFormState, Repositorio>((ref, repositorio) {

  // final createUpdateCallback = ref.watch(repositoriosRepositoryProvider).createUpdateRepositorio;
  final createUpdateCallback = ref.watch(repositoriosProvider.notifier).createOrUpdateRepositorio;

  return RepositorioFormNotifier(
    repositorio: repositorio,
    onSubmitCallback: createUpdateCallback,
  );
});


class RepositorioFormNotifier extends StateNotifier<RepositorioFormState> {

  final Future<bool> Function(Map<String,dynamic> repositorioLike )? onSubmitCallback;


  RepositorioFormNotifier({
    this.onSubmitCallback,
    required Repositorio repositorio,
  }): super(RepositorioFormState(
    id: repositorio.id,
    title: Title.dirty(value: repositorio.title), 
    docente: Docente.dirty(value: repositorio.docente),
    materia: Materia.dirty(value: repositorio.materia),
    tt: TipoTrabajo.dirty(value: repositorio.tt),
    seccion: repositorio.seccion,
    anotacion: repositorio.anotacion ?? '',
    comentario: repositorio.comentario ?? '',
    archivoComprimido: repositorio.archivoComprimido,
  ));

  Future<bool> onRepositorioFormSubmit() async {

    _touchedEverything();

    if(!state.isFormValid) return false;

    if(onSubmitCallback == null) return false;

    final repositorioLike = {
      'id': state.id,
      'title': state.title.value,
      'docente': state.docente.value,
      'materia': state.materia.value,
      'seccion': state.seccion,
      'anotacion': state.anotacion,
      'comentario': state.comentario,
      'archivoComprimido': state.archivoComprimido.map(
        (archivo) => archivo.replaceAll('${ Environment.apiUrl}/files/repositorio', '')
      ).toList(),
      'tt': state.tt.value
    };
    
    try {
      return await onSubmitCallback!(repositorioLike);
      // return true;
    } catch (e) {
      return false;
    }
  }

  void _touchedEverything(){
    state = state.copyWith(
      isFormValid: Formz.validate([
        Title.dirty(value: state.title.value),
        Docente.dirty(value: state.docente.value),
        Materia.dirty(value: state.materia.value),
        TipoTrabajo.dirty(value: state.tt.value),
      ])
    );
  }

  void onTitleChanged(String value){
    state = state.copyWith(
      title: Title.dirty(value: value),
      isFormValid: Formz.validate([
        Title.dirty(value: value),
        Docente.dirty(value: state.docente.value),
        Materia.dirty(value: state.materia.value),
        TipoTrabajo.dirty(value: state.tt.value),
      ])
    );
  }

  void onDocenteChanged(String value){
    state = state.copyWith(
      docente: Docente.dirty(value: value),
      isFormValid: Formz.validate([
        Title.dirty(value: state.title.value),
        Docente.dirty(value: value),
        Materia.dirty(value: state.materia.value),
        TipoTrabajo.dirty(value: state.tt.value),
      ])
    );
  }

  void onMateriaChanged(String value){
    state = state.copyWith(
      materia: Materia.dirty(value: value),
      isFormValid: Formz.validate([
        Title.dirty(value: state.title.value),
        Docente.dirty(value: state.docente.value),
        Materia.dirty(value: value),
        TipoTrabajo.dirty(value: state.tt.value),
      ])
    );
  }

  void onTipoTrabajoChanged(String value){
    state = state.copyWith(
      tt: TipoTrabajo.dirty(value: value),
      isFormValid: Formz.validate([
        Title.dirty(value: state.title.value),
        Docente.dirty(value: state.docente.value),
        Materia.dirty(value: state.materia.value),
        TipoTrabajo.dirty(value: value),
      ])
    );
  }

  void onSeccionChanged(int value){
    state = state.copyWith(seccion: value <= 0 ? 1 : value);
  }

  void onAnotacionChanged(String value){
    state = state.copyWith(anotacion: value);
  }

  void onComentarioChanged(String value){
    state = state.copyWith(comentario: value);
  }
  
}


class RepositorioFormState {

  final bool isFormValid;
  final String? id;
  final Title title;
  final Docente docente;
  final Materia materia;
  final TipoTrabajo tt;
  final int seccion;
  final String anotacion;
  final String comentario;
  final List<String> archivoComprimido;

  RepositorioFormState({
    this.isFormValid = false, 
    this.id, 
    this.title = const Title.dirty(), 
    this.docente = const Docente.dirty(), 
    this.materia = const Materia.dirty(), 
    this.tt = const TipoTrabajo.dirty(), 
    this.seccion = 0, 
    this.anotacion = '', 
    this.comentario = '', 
    this.archivoComprimido = const [],
  });

  RepositorioFormState copyWith({
    bool? isFormValid,
    String? id,
    Title? title,
    Docente? docente,
    Materia? materia,
    TipoTrabajo? tt,
    int? seccion,
    String? anotacion,
    String? comentario,
    List<String>? archivoComprimido,
  }) => RepositorioFormState(
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    title: title ?? this.title,
    docente: docente ?? this.docente,
    materia: materia ?? this.materia,
    tt: tt ?? this.tt,
    seccion: seccion ?? this.seccion,
    anotacion: anotacion ?? this.anotacion,
    comentario: comentario ?? this.comentario,
    archivoComprimido: archivoComprimido ?? this.archivoComprimido,
  );

}