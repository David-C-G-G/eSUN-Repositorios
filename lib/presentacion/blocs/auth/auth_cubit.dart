import 'package:esun/shared/services/key_value_storage_service_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:esun/infrastructure/infraestructure.dart';
import '../../../domain/domain.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  AuthCubit() : super(const AuthState()){
    // checkAuthStatus();
  }

  final AuthRepositoryImpl authRepository = AuthRepositoryImpl();
  final KeyValueStorageServiceImpl keyvalueStorageService = KeyValueStorageServiceImpl();

  Future<void> loginUser( String email, String password ) async {  //! COMPLETO
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

  Future<void> registerUser( String email, String password, String fullNamed, String? cedula ) async {
    emit(
      state.copyWith(authStatus: AuthStatus.checking
      )
    );

    try {
      final user = await authRepository.register(email, password, fullNamed, cedula);
      _setRegisteredUser(user);
    }on CustomError catch (e) {
      registrationError(e.message);
    } catch (e) {
      registrationError('Error no controlado');
    }
  }

  void checkAuthStatus() async {
    final token = await keyvalueStorageService.getKey<String>('token');

    if( token == null ) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser( User user) async { 
    
    await keyvalueStorageService.setKeyValue('token', user.token);

    emit(
        state.copyWith(
        user: user,
        authStatus: AuthStatus.authenticated,
        errorMessage: '',
      )
    );
  }

  void _setRegisteredUser( User user) {
    emit(
      state.copyWith(
        user: user,
        authStatus: AuthStatus.registered
      )
    );
  }

  Future<void> logout([String? errorMessage]) async { 
    
    await keyvalueStorageService.removeKey('token');

    emit(
      state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage
      )
    );
  }

  Future<void> registrationError([String? errorMessage]) async {
    emit(
      state.copyWith(
        authStatus: AuthStatus.notRegistered,
        user: null,
        errorMessage: errorMessage
      )
    );
  }

}
