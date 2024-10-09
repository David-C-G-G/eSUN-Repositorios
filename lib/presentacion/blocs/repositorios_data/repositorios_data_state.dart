part of 'repositorios_data_cubit.dart';

class RepositoriosDataState extends Equatable {

  final bool isLastPage;
  final int limiteEntidades;
  final int pagina;
  final bool isLoading;
  final List<Repositorio> repositorios;


  const RepositoriosDataState({
    this.isLastPage = false, 
    this.limiteEntidades = 10, 
    this.pagina = 0, 
    this.isLoading = false, 
    this.repositorios = const [],
  });

  RepositoriosDataState copyWith({
    bool? isLastPage,
    int? limiteEntidades,
    int? pagina,
    bool? isLoading,
    List<Repositorio>? repositorios,
  }) => RepositoriosDataState(
    isLastPage: isLastPage ?? this.isLastPage,
    limiteEntidades: limiteEntidades ?? this.limiteEntidades,
    pagina: pagina ?? this.pagina,
    isLoading: isLoading ?? this.isLoading,
    repositorios: repositorios ?? this.repositorios,
  );

  @override
  List<Object> get props => [
    isLastPage,
    limiteEntidades,
    pagina,
    isLoading,
    repositorios,
  ];
}
