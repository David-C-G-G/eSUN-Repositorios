// part of 'auth_cubit.dart';

// enum AuthStatus { checking, authenticated, notAuthenticated, registered, notRegistered }

// class AuthState extends Equatable {
  
//   final AuthStatus authStatus;
//   final User? user;
//   final String errorMessage;

//   const AuthState({
//     this.authStatus = AuthStatus.checking, 
//     this.user, 
//     this.errorMessage = '',
//   });

//   AuthState copyWith({
//     AuthStatus? authStatus,
//     User? user,
//     String? errorMessage,
//   }) => AuthState(
//     authStatus: authStatus ?? this.authStatus,
//     user: user ?? this.user,
//     errorMessage: errorMessage ?? this.errorMessage,
//   );


//   // posiblemente me marque un error, ya que no permite agregar al usuario
//   @override
//   List<Object?> get props => [ authStatus,user, errorMessage ];
// }
