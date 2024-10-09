



import 'package:esun/infrastructure/features/domain/domain.dart';

class RepositoriosRepositoryImpl extends RepositoriosRepository{

  final RepositoriosDatasource datasource;

  RepositoriosRepositoryImpl(this.datasource);


  @override
  Future<Repositorio> createUpdateRepositorio(Map<String, dynamic> repositorioLike) {
    return datasource.createUpdateRepositorio(repositorioLike);
  }

  @override
  Future<Repositorio> getRepositorioById(String id) {
    return datasource.getRepositorioById(id);
  }

  @override
  Future<List<Repositorio>> getRepositoriosByPage({int limiteEntidades = 10, int pagina = 0}) {
    return datasource.getRepositoriosByPage(limiteEntidades: limiteEntidades, pagina: pagina);
  }

  @override
  Future<Repositorio> searchRepositorioByTerm(String term) {
    return datasource.searchRepositorioByTerm(term);
  }
}