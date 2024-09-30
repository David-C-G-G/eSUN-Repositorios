


import 'package:esun/domain/domain.dart';

abstract class AuthDatasource {

  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String fullNamed, String? cedula);
  Future<User> checkAuthStatus(String token);
}