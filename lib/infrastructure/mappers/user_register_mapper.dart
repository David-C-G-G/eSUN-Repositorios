


import 'package:esun/domain/domain.dart';

class UserRegisterMapper {

  static User userJsonEntity( Map<String, dynamic> json ) => User(
    id: json['id'], 
    email: json['email'], 
    fullName: json['fullName'], 
    roles: List<String>.from(json['roles'].map( (role) => role )),
    cedula: json['cedula'], 
    token: json['token'],
  );
}