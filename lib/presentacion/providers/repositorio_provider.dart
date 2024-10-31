


import 'package:esun/infrastructure/features/domain/domain.dart';
import 'package:esun/presentacion/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repositorioProvider = StateNotifierProvider.autoDispose.family<RepositorioNotifier, RepositorioState, String>((ref, repositorioId) {

  final repositoriosRepository = ref.watch(repositoriosRepositoryProvider);

  return RepositorioNotifier(
    repositoriosRepository: repositoriosRepository, 
    repositorioId: repositorioId
  );
});

class RepositorioNotifier extends StateNotifier<RepositorioState> {

  final RepositoriosRepository repositoriosRepository;


  RepositorioNotifier({
    required this.repositoriosRepository,
    required String repositorioId,
  }): super(RepositorioState(id: repositorioId)){
    loadRepositorio();
  }

  Repositorio newEmptyRepositorio(){
    return Repositorio(
      id: 'new', 
      title: '', 
      docente: '', 
      materia: '', 
      seccion: 0, 
      anotacion: '', 
      comentario: '', 
      tt: 'tarea', 
      archivoComprimido: [], 
    );
  }

  Future<void> loadRepositorio() async {

    try {

      if(state.id == 'new'){
        state = state.copyWith(
          isLoading: false,
          repositorio: newEmptyRepositorio(),
        );
        return;
      }

      final repositorio = await repositoriosRepository.getRepositorioById(state.id);
      state = state.copyWith(
        isLoading: false,
        repositorio: repositorio
      );
    } catch (e) {
      print(e);
    }
  }
  
}

class RepositorioState {

  final String id;
  final Repositorio? repositorio;
  final bool isLoading;
  final bool isSaving;

  RepositorioState({
    required this.id, 
    this.repositorio, 
    this.isLoading = true, 
    this.isSaving = false,
  });

  RepositorioState copyWith({
    String? id,
    Repositorio? repositorio,
    bool? isLoading,
    bool? isSaving,
  }) => RepositorioState(
    id: id ?? this.id,
    repositorio: repositorio ?? this.repositorio,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );

  
}