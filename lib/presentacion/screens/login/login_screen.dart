import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// import 'package:esun/presentacion/blocs/blocs.dart';
import 'package:esun/presentacion/blocs/login/login_cubit.dart';
import 'package:esun/presentacion/widgets.dart';

class LoginScreen extends StatelessWidget {

  static const String name = 'LoginScreen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const _LoginUser(),
    );
  }
}
//------------

class _LoginUser extends StatelessWidget {
  const _LoginUser();

  @override
  Widget build(BuildContext context) {

    FocusScopeNode currentFocus = FocusScope.of(context); //esto es para quitar el teclado si no esta activo el formulario

    return GestureDetector(
      onTap: 
      () {
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: const Scaffold(
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
      ),
    );
  }
}

class _LoginFormField extends StatelessWidget {
  const _LoginFormField();

  @override
  Widget build(BuildContext context) {

    final loginCubit = context.watch<LoginCubit>();//mandamos a traer el cubit para adjuntar caracteristicas al formulario

    final username = loginCubit.state.email;
    final password = loginCubit.state.password;

    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
      
            const SizedBox(height: 20,),
      
            CustomFormField( //formulario de Nombre de usuario
              label: 'email',
              onChanged: loginCubit.email,
              color: 'blanco',
              errorMsg: username.errorMessage,
                // username.errorMessage
                // : null,
            ),
      
            const SizedBox(height: 20,),
      
            CustomFormField( //formulario de password
              label: 'password',
              obscureText: true,
              onChanged: loginCubit.password,
              color: 'blanco',
              errorMsg: password.errorMessage,
            ),
      
            const SizedBox(height: 40,),
      
            SizedBox(
              width: double.infinity,
              child: Row( //renglon en donde metemos 2 botones
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    texto: 'Ingresar',
                    // onTap: () => context.push('/option') 
                    onTap: () => loginCubit.onSubmit(),
                      //TODO: verificar los datos con la base de datos
                  ),

                  // const Spacer(),
                    
                  CustomButton(
                    texto: 'Regresar',
                    onTap: (){
                      context.pop();
                    },
                  ),
                ],
              ),
            ),
      
          ],
        ),
      ),
    );
  }
}