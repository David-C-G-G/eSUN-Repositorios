
import 'package:esun/infrastructure/inputs.dart';
import 'package:esun/presentacion/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier,RegisterFormState>((ref) {

  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;

  return RegisterFormNotifier(registerUserCallback: registerUserCallback, ref: ref);
});


class RegisterFormNotifier  extends StateNotifier<RegisterFormState> {

  final Function(String, String, String, String?) registerUserCallback;
  final StateNotifierProviderRef ref;

  RegisterFormNotifier({
    required this.registerUserCallback,
    required this.ref,
  }):super(RegisterFormState());

  void onUserNameRegisterChange(String value){
    final newUserNameRegister = Username.dirty(value: value);
    state = state.copyWith(
      userName: newUserNameRegister,
      isValid: Formz.validate([newUserNameRegister, state.email, state.password, state.cedula])
    );
  }

  void onEmailRegisterChange(String value){
    final newEmailRegister = Email.dirty(value: value);
    state = state.copyWith(
      email: newEmailRegister,
      isValid: Formz.validate([newEmailRegister, state.userName, state.password, state.cedula])
    );
  }

  void onPasswordRegisterChange(String value){
    final newPasswordREgister = Password.dirty(value: value);
    state = state.copyWith(
      password: newPasswordREgister,
      isValid: Formz.validate([newPasswordREgister, state.userName, state.email, state.cedula])
    );
  }

  void onIsDocenteChange(bool value){
    state = state.copyWith(isDocente: value);
    // si se desactiva el switch, vaciamos la cédula
    if(!value){
      state = state.copyWith(cedula: const Cedula.pure());
    }
  }
  
  void onCedulaRegisterChange(String value){
    final newCedulaRegister = Cedula.dirty(value: value);
    state = state.copyWith(
      cedula: newCedulaRegister,
      isValid: Formz.validate([newCedulaRegister, state.userName, state.email, state.password])
    );
  }

  Future<bool> onFormSubmit() async {
    _touchEveryFieldRegister();

    if(!state.isValid) return false;

    final isRegistered = await registerUserCallback(
      state.userName.value,
      state.email.value,
      state.password.value,
      state.cedula.value.isNotEmpty ? state.cedula.value : null,
    );

    if(isRegistered){
      ref.read(authProvider.notifier).updateAuthStatus(AuthStatus.notAuthenticated);
      final emailSender = EmailSender();
      final emailSent = await emailSender.sendMail(email: state.email.value, usuario: state.userName.value);
      return emailSent;
      // return true;
    } else {
      return false;
    }
    
  }

  void _touchEveryFieldRegister(){
    final userName = Username.dirty(value: state.userName.value);
    final email = Email.dirty(value: state.email.value);
    final password = Password.dirty(value: state.password.value);
    final cedula = Cedula.dirty(value: state.cedula.value);

    state = state.copyWith(
      isRegisterFormPosted: true,
      userName: userName,
      email: email,
      password: password,
      cedula: cedula,
      isValid: Formz.validate([userName,email,password,cedula])
    );
  }


}

class RegisterFormState {

  final bool isPosting;
  final bool isRegisterFormPosted;
  final bool isValid;
  final bool isDocente;
  final Username userName;
  final Email email;
  final Password password;
  final Cedula cedula;

  RegisterFormState({
    this.isPosting = false, 
    this.isRegisterFormPosted = false, 
    this.isValid = false,
    this.isDocente = false,
    this.userName = const Username.pure(), 
    this.email = const Email.pure(), 
    this.password = const Password.pure(), 
    this.cedula = const Cedula.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isRegisterFormPosted,
    bool? isValid,
    bool? isDocente,
    Username? userName,
    Email? email,
    Password? password,
    Cedula? cedula,
  }) => RegisterFormState(
    isPosting : isPosting ?? this.isPosting,
    isRegisterFormPosted : isRegisterFormPosted ?? this.isRegisterFormPosted,
    isValid : isValid ?? this.isValid,
    isDocente: isDocente ?? this.isDocente,
    userName : userName ?? this.userName,
    email : email ?? this.email,
    password : password ?? this.password,
    cedula : cedula ?? this.cedula,
  );

  @override
  String toString() {
    return '''
      RegisterFormState:
        isPosting: $isPosting
        isRegisterFormPosted: $isRegisterFormPosted
        isValid: $isValid
        isDocente: $isDocente
        userName: $userName
        email: $email
        password: $password
        cedula: $cedula
    ''';
  }


}