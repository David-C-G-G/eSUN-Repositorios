import 'package:esun/infrastructure/features/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'repositorio_state.dart';

class RepositorioCubit extends Cubit<RepositorioState> {

final RepositoriosRepository repositoriosRepository;

  RepositorioCubit({
    required this.repositoriosRepository,
    required String repositorioId,
  }) : super(RepositorioState(id: repositorioId)){
    loadRepositorio();
  }


  Future<void> loadRepositorio() async {
    emit(
      state.copyWith(isLoading: true)
    );

    try {
      final repositorio = await repositoriosRepository.getRepositorioById(state.id);
      emit(
        state.copyWith(repositorio: repositorio, isLoading: false)
      );  
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      print("Error al cargar el repositorio: $e");
    }
    
  }

  // Future<>
}
