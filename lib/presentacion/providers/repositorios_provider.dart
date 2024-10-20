
import 'package:esun/presentacion/providers/repositorios_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/features/domain/domain.dart';


final repositoriosProvider = StateNotifierProvider<RepositoriosNotifier, RepositoriosState>((ref) {

  final repositoriosRepository = ref.watch(repositoriosRepositoryProvider);

  return RepositoriosNotifier(repositoriosRepository: repositoriosRepository);
});


class RepositoriosNotifier extends StateNotifier<RepositoriosState> {

  final RepositoriosRepository repositoriosRepository;

  RepositoriosNotifier({
    required this.repositoriosRepository
  }): super( RepositoriosState() ){
    loadNextPage();
  }

  Future loadNextPage() async {

    if( state.isLoading || state.isLastPage ) return;

    state = state.copyWith( isLoading:  true );

    final repositorios = await repositoriosRepository
      .getRepositoriosByPage(limiteEntidades: state.limiteEntidades, pagina: state.pagina);

      if( repositorios.isEmpty ){
        state = state.copyWith(
          isLoading: false,
          isLastPage: true,
        );
        return;
      }

      state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        pagina: state.pagina + 10,
        repositorios: [...state.repositorios, ...repositorios]
      );
  }
  
}

class RepositoriosState {

  final bool isLastPage;
  final int limiteEntidades;
  final int pagina;
  final bool isLoading;
  final List<Repositorio> repositorios;

  RepositoriosState({
    this.isLastPage = false, 
    this.limiteEntidades = 10, 
    this.pagina = 0, 
    this.isLoading = false, 
    this.repositorios = const[],
  });

  RepositoriosState copyWith({
    bool? isLastPage,
    int? limiteEntidades,
    int? pagina,
    bool? isLoading,
    List<Repositorio>? repositorios,
  }) => RepositoriosState(
    isLastPage: isLastPage ?? this.isLastPage,
    limiteEntidades: limiteEntidades ?? this.limiteEntidades,
    pagina: pagina ?? this.pagina,
    isLoading: isLoading ?? this.isLoading,
    repositorios: repositorios ?? this.repositorios,
  );

}