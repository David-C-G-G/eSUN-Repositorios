import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:esun/infrastructure/features/domain/domain.dart';

part 'repositorios_data_state.dart';

class RepositoriosDataCubit extends Cubit<RepositoriosDataState> {

  RepositoriosDataCubit({
   required this.repositoriosRepository
  }) : super(const RepositoriosDataState()){
    loadNextPage();
  }

  final RepositoriosRepository repositoriosRepository;

  Future loadNextPage() async {

    if (_shouldStopLoading()) return;

    emit(state.copyWith( isLoading: true ) );

    try {
      final repositorios = await _fetchRepositorios();

      if( repositorios.isEmpty ) {
        emit(
          state.copyWith(
            isLoading: false,
            isLastPage: true,
          )
        );
        return;
      }

      final repositoriosUnicos = repositorios.where(
        (newRepositorio){
          return !state.repositorios.any((existingRepositorio) => 
            existingRepositorio.id == newRepositorio.id );
        }
      ).toList();

      _appendRepositorios(repositoriosUnicos);
      
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      print('Error cargando repositorios $e');
    }
  }

  bool _shouldStopLoading(){ // devuelve el valor boleano si esta o no cargando o en la pagina final
    return state.isLoading || state.isLastPage;
  }

  Future<List<Repositorio>> _fetchRepositorios(){ // obtiene la lista del limite de entidades y de paginas
    return repositoriosRepository.getRepositoriosByPage(
      limiteEntidades: state.limiteEntidades,
      pagina: state.pagina,
    );
  }

  void _appendRepositorios(List<Repositorio> repositorios){
    emit(
      state.copyWith(
        isLoading: false,
        isLastPage: false,
        pagina: state.pagina + 1,
        repositorios: [...state.repositorios, ...repositorios],
      )
    );
  }

}
