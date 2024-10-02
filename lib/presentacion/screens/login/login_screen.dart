import 'package:esun/presentacion/blocs/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// import 'package:esun/presentacion/blocs/blocs.dart';
import 'package:esun/presentacion/blocs/login/login_cubit.dart';
import 'package:esun/presentacion/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const String name = 'LoginScreen';

  const LoginScreen({super.key});

  // Creación y personalización del snackbar
  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.amber,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state.authStatus == AuthStatus.authenticated){
          context.push('/option');
        } else if(state.authStatus == AuthStatus.notAuthenticated && state.errorMessage.isNotEmpty){
          showSnackbar(context, state.errorMessage);
          context.read<AuthCubit>().logout();
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: _LoginUser(showSnackbar: showSnackbar,),
      ),
    );
  }
}
//------------

class _LoginUser extends StatelessWidget {

  final Function(BuildContext, String) showSnackbar;

  const _LoginUser({required this.showSnackbar});

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(
        context); //esto es para quitar el teclado si no esta activo el formulario

    return GestureDetector(
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) {
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
                  // _LoginFormField(showSnackbar: showSnackbar),
                  SizedBox(
                    height: 20,
                  )
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

  //  final Function(BuildContext, String) showSnackbar;
   

  // const _LoginFormField({required this.showSnackbar});
  const _LoginFormField();

  @override
  Widget build(BuildContext context) {

    final loginCubit = context.watch<LoginCubit>(); //mandamos a traer el cubit para adjuntar caracteristicas al formulario

    final checkMessage = context.watch<AuthCubit>();

    final username = loginCubit.state.email;
    final password = loginCubit.state.password;

    

    // if (checkMessage.state.errorMessage.isNotEmpty &&
    //     checkMessage.state.authStatus == AuthStatus.notAuthenticated) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     showSnackbar(context, checkMessage.state.errorMessage);
       
    //     checkMessage.logout();
    //   });
    // }

    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomFormField(
              //formulario de Nombre de usuario
              label: 'email',
              onChanged: (value) {
                loginCubit.email(value);
                if (checkMessage.state.errorMessage.isNotEmpty) {
                  checkMessage.logout();
                }
              },
              color: 'blanco',
              errorMsg: username.errorMessage,
              // username.errorMessage
              // : null,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomFormField(
              //formulario de password
              label: 'password',
              obscureText: true,
              onChanged: (value) {
                loginCubit.password(value);
                if (checkMessage.state.errorMessage.isNotEmpty) {
                  checkMessage.logout();
                }
              },
              color: 'blanco',
              errorMsg: password.errorMessage,
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                //renglon en donde metemos 2 botones
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    texto: 'Ingresar',
                    
                    onTap: loginCubit.state.formStatus == FormStatus.posting
                    ? null 
                    : () {
                      loginCubit.onSubmit();                      
                    },
                  ),

                  // const Spacer(),

                  CustomButton(
                    texto: 'Regresar',
                    onTap: () {
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
