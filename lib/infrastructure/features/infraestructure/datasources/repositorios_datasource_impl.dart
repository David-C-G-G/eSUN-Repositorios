


import 'package:dio/dio.dart';
import 'package:esun/config/config.dart';
import 'package:esun/infrastructure/features/domain/domain.dart';

import '../errors/repositorio_errors.dart';
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
  Future<Repositorio> createUpdateRepositorio(Map<String, dynamic> repositorioLike) async {
    try {
      final String? repositorioId = repositorioLike['id'];
      final String method = (repositorioId == null) ? 'POST' : 'PATCH';
      final String url = (repositorioId == null) ? '/repositorio' : '/repositorio/$repositorioId';

      // Elimina el ID del cuerpo antes de enviarlo al backend
      repositorioLike.remove('id');


      final response = await dio.request(
        url,
        data: repositorioLike,
        options: Options(method: method),
      );

      final repositorio = RepositorioMapper.jsonToEntity(response.data);
      return repositorio;
    } on DioException catch (e){

      if(e.response != null && e.response!.statusCode == 404){
        throw RepositorioNotFound();
      }else{
        throw Exception('Error al actualizar el repositorio: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error inesperado $e');
    }
  }

  @override
  Future<Repositorio> getRepositorioById(String id) async {
    try {
      final response = await dio.get('/repositorio/$id');
      final repositorio = RepositorioMapper.jsonToEntity(response.data);
      return repositorio;
    } on DioException catch (e){
      if(e.response!.statusCode == 404 ) throw RepositorioNotFound();
      throw Exception();
    }
    catch (e) {
      throw Exception(e);
    }
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