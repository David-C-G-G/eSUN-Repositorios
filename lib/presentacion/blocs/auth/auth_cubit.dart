import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:esun/infrastructure/infraestructure.dart';
import '../../../domain/domain.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  final AuthRepositoryImpl authRepository = AuthRepositoryImpl();

  Future<void> loginUser( String email, String password ) async {
    emit(
      state.copyWith(authStatus: AuthStatus.checking,)
    );

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e){
      logout('Error no controlado');
    }
    
  }

  void registerUser( String email, String password, String fullNamed, String? cedula ) async {
    emit(
      state.copyWith(authStatus: AuthStatus.checking
      )
    );

    try {
      final user = await authRepository.register(email, password, fullNamed, cedula);
      emit(state.copyWith(authStatus: AuthStatus.authenticated, user: user)); 
    } catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.notAuthenticated, errorMessage: e.toString()));
    }
  }

  void checkAuthStatus() async {}

  void _setLoggedUser( User user) {
    //TODO: needs save the token 

    emit(
        state.copyWith(
        user: user,
        authStatus: AuthStatus.authenticated,
      )
    );
  }

  Future<void> logout([String? errorMessage]) async {
    // TODO: clean token 
    emit(
      state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage
      )
    );
  }

}
