// part of 'register_cubit.dart';

// enum FormStatus { invalid, valid, validating, posting }

// class RegisterFormState extends Equatable {


//   final FormStatus formStatus;
//   final bool isValid;
//   final Username userName;
//   final Email email;
//   final Password password;
//   final Cedula cedula;

//   const RegisterFormState({
    
//     this.formStatus = FormStatus.invalid, 
//     this.isValid = false,
//     this.userName = const Username.pure(), 
//     this.email = const Email.pure(), 
//     this.password = const Password.pure(),
//     this.cedula = const Cedula.pure(),

//   });

//   RegisterFormState copyWith({
//     FormStatus? formStatus,
//     bool?       isValid,
//     Username?   userName,
//     Email?      email,
//     Password?   password,
//     Cedula?     cedula,
//   }) => RegisterFormState(
//     formStatus: formStatus ?? this.formStatus,
//     isValid   : isValid    ?? this.isValid,
//     userName  : userName   ?? this.userName,
//     email     : email      ?? this.email,
//     password  : password   ?? this.password,
//     cedula    : cedula     ?? this.cedula,
//   );


//   // const RegisterFormState();

//   @override
//   List<Object> get props => [formStatus, isValid, userName, email, password, cedula];
// }
