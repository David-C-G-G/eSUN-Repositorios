


import 'package:dio/dio.dart';
import 'package:esun/config/config.dart';
import 'package:esun/domain/domain.dart';
import 'package:esun/infrastructure/infraestructure.dart';


class AuthDatasourceImpl extends AuthDatasource {

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    )
  );

  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
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
      
    } catch (e) {
      throw WrongCredentials();      
    }
  }

  @override
  Future<User> register(String email, String password, String fullNamed, String? cedula) {
    // TODO: implement register
    throw UnimplementedError();
  }
  
}