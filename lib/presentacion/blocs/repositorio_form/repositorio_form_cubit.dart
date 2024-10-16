import 'package:esun/config/config.dart';
import 'package:esun/infrastructure/features/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esun/infrastructure/inputs.dart';
import 'package:formz/formz.dart';

part 'repositorio_form_state.dart';

class RepositorioFormCubit extends Cubit<RepositorioFormState> {
  
  final Future<bool> Function( Map<String,dynamic> repositorioLike)? onSubmitCallback;

  RepositorioFormCubit({
    this.onSubmitCallback,
    required Repositorio repositorio,
  }) : super(RepositorioFormState(
    
    id: repositorio.id,
    title: Title.dirty(repositorio.title),
    docente: Docente.dirty(repositorio.docente),
    materia: Materia.dirty(repositorio.materia),
    tt: TipoTrabajo.dirty(repositorio.tt),
    seccion: repositorio.seccion,
    anotacion: repositorio.anotacion,
    comentario: repositorio.comentario,
    archivoComprimido: repositorio.archivoComprimido,
  ));

  Future<bool> onFormSubmit() async {
    
    _touchEverything();

    if( !state.isFormValid ) return false;

    if( onSubmitCallback == null ) return false;

    final repositorioLike = {
      'id': state.id,
      'title': state.title.value,
      'docente': state.docente.value,
      'materia': state.materia.value,
      'seccion': state.seccion,
      'anotacion': state.anotacion,
      'comentario': state.comentario,
      'archivoComprimido': (state.archivoComprimido ?? []).map(
        (archivo) => archivo.replaceAll('${Environment.apiUrl}/files/repositorio', '')
      ).toList() ,
      'tt': state.tt.value,
    };
    
    try {
      // llama al callback para crear/actualizar el repositorio
      return await onSubmitCallback!(repositorioLike);
    } catch (e) {
      // manejar error, puedes emitir un estado de error
      print('Error al enviar el formulario: $e');
      return false;
    }

  }

  void _touchEverything(){
    emit(state.copyWith(
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Docente.dirty(state.docente.value),
        Materia.dirty(state.materia.value),
        TipoTrabajo.dirty(state.tt.value),
      ])
    ));
  }

  void onTitleChanged(String value){
    emit(
      state.copyWith(
        title: Title.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(value),
          Docente.dirty(state.docente.value),
          Materia.dirty(state.materia.value),
          TipoTrabajo.dirty(state.tt.value),
        ])
      )
    );
  }
  void onDocenteChanged(String value){
    emit(
      state.copyWith(
        docente: Docente.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Docente.dirty(value),
          Materia.dirty(state.materia.value),
          TipoTrabajo.dirty(state.tt.value),
        ])
      )
    );
  }
  void onMateriaChanged(String value){
    emit(
      state.copyWith(
        materia: Materia.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Docente.dirty(state.docente.value),
          Materia.dirty(value),
          TipoTrabajo.dirty(state.tt.value),
        ])
      )
    );
  }
  void onTipoTrabajoChanged(String value){
    emit(
      state.copyWith(
        tt: TipoTrabajo.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Docente.dirty(state.docente.value),
          Materia.dirty(state.materia.value),
          TipoTrabajo.dirty(value),
        ])
      )
    );
  }

  void onSeccionChanged( int seccion){
    emit(
      state.copyWith(seccion: seccion)
    );
  }

  void onAnotacionChanged( String anotacion){
    emit(
      state.copyWith(anotacion: anotacion)
    );
  }

  void onComentarioChanged(String comentario){
    emit(
      state.copyWith(comentario: comentario)
    );
  }


}
