// import 'dart:convert';

import 'package:esun/presentacion/blocs/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:emailjs/emailjs.dart' as emailjs;
// import 'package:http/http.dart' as http;

import 'package:esun/infrastructure/inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {

  final AuthCubit authCubit;

  RegisterCubit(this.authCubit) : super(const RegisterFormState());

  // resetea el formulario
  void resetForm(){
    emit(const RegisterFormState());
  }

  void onSubmit() async {

    final cedulaInput = state.cedula.value.isEmpty ? const Cedula.pure() : Cedula.dirty(value: state.cedula.value);

       // validando entradas y actualiza el estado
    final isValid = Formz.validate([
      state.userName,
      state.email,
      state.password,
      if(cedulaInput.value.isNotEmpty) cedulaInput,
    ]);

    emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        userName: Username.dirty( value: state.userName.value ),
        password: Password.dirty( value: state.password.value ),
        email   : Email.dirty(value: state.email.value),
        cedula  : cedulaInput,

        isValid: isValid,
      )
    );
    if( state.isValid) {

      emit(state.copyWith(formStatus: FormStatus.valid));
      await authCubit.registerUser(
        state.email.value, 
        state.password.value, 
        state.userName.value, 
        state.cedula.value
      );
      print('Register Cubit Submit: $state');
    }else {
      emit(state.copyWith(formStatus: FormStatus.invalid));
    }
  }


  void userName( String value ){

    final username = Username.dirty(value: value);

  
    emit(
      state.copyWith(
        userName: username,
        isValid: Formz.validate([username, state.email, state.password, state.cedula]),
      )
    );
  }


  void email( String value ){

    final email = Email.dirty(value: value);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.userName, state.password, state.cedula])
      )
    );
  }


  void password( String value ){

    final password = Password.dirty(value: value);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.userName, state.email, state.cedula])
      )
    );
  }

  void cedula( String value ){

    // final cedula = Cedula.dirty(value: value);
    // crea cédla solo si hay un valor
    final cedulaInput = value.isEmpty ? const Cedula.pure() : Cedula.dirty(value: value);

    emit(
      state.copyWith(
        cedula: cedulaInput,
        isValid: Formz.validate([
          state.userName, 
          state.email, 
          state.password,
          if(cedulaInput.value.isNotEmpty) cedulaInput
        ])
      )
    );
  }

}
