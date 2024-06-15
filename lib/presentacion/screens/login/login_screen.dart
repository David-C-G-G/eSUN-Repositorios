import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:esun/presentacion/blocs/blocs.dart';
import 'package:esun/presentacion/widgets.dart';

class LoginScreen extends StatelessWidget {

  static const String name = 'LoginScreen';

  const LoginScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: const _LoginUser(),
    );
  }
}

class _LoginUser extends StatelessWidget {
  const _LoginUser();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(6, 20, 68, 1),
      body: SafeArea(
        child: Padding(
          // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LogoWidget(),

                _LoginFormField(),

                SizedBox(height: 20,)



              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginFormField extends StatelessWidget {
  const _LoginFormField();

  @override
  Widget build(BuildContext context) {

    final registerCubit = context.watch<RegisterCubit>();

    final username = registerCubit.state.userName;
    final password = registerCubit.state.password;

    return Form(
      child: Column(
        children: [

          const SizedBox(height: 20,),

          CustomFormField(
            label: 'nombre de usuario',
            onChanged: registerCubit.userName,
            color: 'blanco',
            errorMsg: username.errorMessage,
          ),

          const SizedBox(height: 20,),

          CustomFormField(
            label: 'password',
            obscureText: true,
            onChanged: registerCubit.password,
            color: 'blanco',
            errorMsg: password.errorMessage,
          ),

          const SizedBox(height: 40,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                texto: (username.isNotValid || password.isNotValid) 
                  ? 'Deshabilitado'
                  : 'Iniciar Sesión',
                onTap: username.isNotValid || password.isNotValid 
                  ? null
                  : () => registerCubit.onSubmit(),
              ),

              CustomButton(
                texto: '    Regresar     ',
                onTap: (){
                  context.pop();
                },
              ),
            ],
          ),

        ],
      ),
    );
  }
}