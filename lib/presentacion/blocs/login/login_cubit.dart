// Create By Ing. David C. Gutiérrez Gutiérrez
import 'package:esun/presentacion/blocs/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:esun/infrastructure/inputs.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginFormState> {

  final AuthCubit authcubit;


  LoginCubit(this.authcubit) : super(const LoginFormState());

  void onSubmit() async {
    
    emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        email: Email.dirty(value: state.email.value),
        password: Password.dirty(value: state.password.value),

        isValid: Formz.validate([
          state.email,
          state.password
        ])
      )
    );

    if ( !state.isValid ) return;

    await  authcubit.loginUser(state.email.value, state.password.value);
  }

  void email( String value){

    final email = Email.dirty(value:  value);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([ email, state.password ])
      )
    );
  }
  
  void password( String value){

    final password = Password.dirty(value:  value);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.email])
      )
    );
  }
}
