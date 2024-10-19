
import 'package:esun/domain/domain.dart';
import 'package:esun/infrastructure/infraestructure.dart';
import 'package:esun/shared/services/key_value_storage_service.dart';
import 'package:esun/shared/services/key_value_storage_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authProvider = StateNotifierProvider<AuthNotifier,AuthState>((ref) {

  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});



class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService
  }): super(AuthState()){
    checkAuthStatus();
  }

  Future<void> loginUser( String email, String password ) async {

    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);

    } on CustomError catch (e){
      logout(e.message);
    } catch (e){
      logout('Error no controlado');
    }
    
  }

  Future<bool> registerUser( String userName, String email, String password, String? cedula  ) async {

    await Future.delayed(const Duration(milliseconds: 500));

    try {
      await authRepository.register(email, password, userName, cedula);
      state = state.copyWith(authStatus: AuthStatus.registrationSuccess);
      return true;
    } on CustomError catch (e) {
      logout(e.message);
      state = state.copyWith(errorMessage: e.message);
      return false;
    } catch (e) {
      logout('Error no controlado');
      state = state.copyWith(errorMessage: e.toString());
      return false;
    }
  }

  Future<void> checkAuthStatus() async {

    final token = await keyValueStorageService.getKey<String>('token');

    if( token == null ) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  void updateAuthStatus(AuthStatus status){
    state = state.copyWith(authStatus: status);
  }

  void _setLoggedUser(User user) async {
    
    await keyValueStorageService.setKeyValue('token', user.token);

    state = state.copyWith(
      user: user,
      // errorMessage: '',
      authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> logout([ String? errorMessage ]) async {
    
    await keyValueStorageService.removeKey('token');
    
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }
  
}

enum AuthStatus{ checking, authenticated, notAuthenticated, registrationSuccess }

class AuthState {

  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking, 
    this.user, 
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );

}