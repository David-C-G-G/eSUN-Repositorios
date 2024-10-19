


import 'package:dio/dio.dart';
import 'package:esun/config/config.dart';
import 'package:esun/domain/domain.dart';
import 'package:esun/infrastructure/infraestructure.dart';
import 'package:esun/infrastructure/mappers/user_register_mapper.dart';


class AuthDatasourceImpl extends AuthDatasource {

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    )
  );

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      
      final response = await dio.get('/auth/check-status', 
        options: Options(
          headers: {
            'Authorization':'Bearer $token'
          }
        )
      );

      final user = UserMapper.userJsonToEntity(response.data);
      return user;

    } on DioException catch (e) {
      if( e.response?.statusCode == 401 ) {
          throw CustomError('Token incorrecto');
        }
      if( e.type == DioExceptionType.connectionTimeout ) throw CustomError('Revisar conexión a internet');
      throw Exception();
    } catch (e) {  
      throw Exception();      
    }
  }

  @override
  Future<User> login(String email, String password) async {


    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password
      });

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
      
    } on DioException catch (e) {
      if( e.response?.statusCode == 401 ) {
          throw CustomError(e.response?.data['message'] ?? 'Credenciales incorrectas' );
        }
      if( e.type == DioExceptionType.connectionTimeout ) throw CustomError('Revisar conexión a internet');
      throw Exception();
    } catch (e) {  
      throw Exception();      
    }
  }

  @override
  Future<User> register(String email, String password, String fullNamed, String? cedula) async {
    
    try {
      final response = await dio.post('/auth/register', data: {
        'email': email,
        'password': password,
        'fullName': fullNamed,
        'cedula': cedula //puede que haya que revisar
      });

      final userRegister = UserRegisterMapper.userJsonEntity(response.data);
      return userRegister;
    }on DioException catch (e) {
      if ( e.response?.statusCode == 400 ){
        throw CustomError(e.response?.data['message'] ?? 'Mala solicitud');
      }
      if( e.type == DioExceptionType.connectionTimeout ) throw CustomError('Revisar conexión a internet');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
  
}