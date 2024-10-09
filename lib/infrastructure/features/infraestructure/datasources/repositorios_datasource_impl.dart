


import 'package:dio/dio.dart';
import 'package:esun/config/config.dart';
import 'package:esun/infrastructure/features/domain/domain.dart';

import '../mappers/repositorio_mapper.dart';

class RepositoriosDatasourceImpl extends RepositoriosDatasource{


  late final Dio dio;
  final String accessToken;

  RepositoriosDatasourceImpl({ 
    required this.accessToken
  }) : dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Authorization':'Bearer $accessToken'
      }
    )
  );


  @override
  Future<Repositorio> createUpdateRepositorio(Map<String, dynamic> repositorioLike) {
    // TODO: implement createUpdateRepositorio
    throw UnimplementedError();
  }

  @override
  Future<Repositorio> getRepositorioById(String id) {
    // TODO: implement getRepositorioById
    throw UnimplementedError();
  }

  @override
  Future<List<Repositorio>> getRepositoriosByPage({int limiteEntidades = 10, int pagina = 0}) async {
    final response = await dio.get<List>('/repositorio?limite_entidades=$limiteEntidades&pagina=$pagina');
    final List<Repositorio> repositorios = [];

    for(final repositorio in response.data ?? [] ){
      repositorios.add( RepositorioMapper.jsonToEntity(repositorio) );
    }

    return repositorios;
  }

  @override
  Future<Repositorio> searchRepositorioByTerm(String term) {
    // TODO: implement searchRepositorioByTerm
    throw UnimplementedError();
  }
}