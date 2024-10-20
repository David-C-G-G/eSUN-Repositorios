

import 'package:equatable/equatable.dart';

class User extends Equatable {

  final String id;
  final String email;
  final String fullName;
  final List<String> roles;
  final String? cedula;
  final String token;

  const User({
    required this.id, 
    required this.email, 
    required this.fullName, 
    required this.roles,
    this.cedula = '', 
    required this.token,
  });

  bool get isAdmin {
    return roles.contains('admin');
  }
  
  @override
  List<Object?> get props => [id, email, fullName, roles, cedula, token];

}