

import '../entities/repositorio.dart';

abstract class RepositoriosDatasource {

  Future<List<Repositorio>> getRepositoriosByPage({ int limiteEntidades = 10, int pagina = 0 });
  Future<Repositorio> getRepositorioById(String id);
  Future<Repositorio> createUpdateRepositorio(Map<String, dynamic> repositorioLike);
  Future<Repositorio> searchRepositorioByTerm(String term);
  
}