part of 'login_cubit.dart';

enum FormStatus { invalid, valid, validating, posting }

class LoginFormState extends Equatable {

  final FormStatus formStatus;
  final bool isValid;
  final Email email;
  final Password password;

  const LoginFormState({
    
    this.formStatus = FormStatus.invalid, 
    this.isValid = false,
    this.email = const Email.pure(), 
    this.password = const Password.pure(),

  });

  LoginFormState copyWith({
    FormStatus? formStatus,
    bool? isValid,
    Email? email,
    Password? password,
  }) => LoginFormState(
    formStatus: formStatus ?? this.formStatus ,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
  );

  @override
  List<Object> get props => [ formStatus, isValid, email, password ];
}
