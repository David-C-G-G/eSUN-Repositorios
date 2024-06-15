import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:esun/infrastructure/inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());


  void onSubmit(){

    emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        userName: Username.dirty( value: state.userName.value ),
        password: Password.dirty( value: state.password.value ),
        email   : Email.dirty(value: state.email.value),
        cedula  : Cedula.dirty(value: state.cedula.value) ,

        isValid: Formz.validate([
          state.userName,
          state.email,
          state.password,
          state.cedula
        ])
      )
    );



    print('Register Cubit Submit: $state');
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

    final cedula = Cedula.dirty(value: value);

    emit(
      state.copyWith(
        cedula: cedula,
        isValid: Formz.validate([cedula, state.userName, state.email, state.password])
      )
    );
  }

}
