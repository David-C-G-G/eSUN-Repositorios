import 'package:esun/presentacion/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:esun/presentacion/providers/providers.dart';
import 'package:esun/presentacion/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const String name = 'LoginScreen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: _LoginUser(),
    );
  }
}
//------------

class _LoginUser extends StatelessWidget {
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
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(6, 20, 68, 1),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const LogoWidget(),
                  const _LoginFormField(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '¿No tienes cuenta?',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () => context.push('/register'),
                          child: const Text('Crea una aquí'))
                    ],
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

class _LoginFormField extends ConsumerWidget {
  const _LoginFormField();

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty && next.authStatus != AuthStatus.authenticated) {
        showSnackbar(context, next.errorMessage);
      } else if (next.authStatus == AuthStatus.authenticated) {
        showSnackbar(context, 'Inicio de sesión correcto');
      }
      // if (next.errorMessage.isEmpty) {
      //   showSnackbar(context, 'Inicio exitoso');
      // }
      // showSnackbar(context, next.errorMessage);
    });

    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomFormField(
              label: 'email',
              hint: 'email',
              onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
              errorMsg:
                  loginForm.isFormPosted ? loginForm.email.errorMessage : null,
              prefixIcon: const Icon(Icons.account_circle_outlined),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomFormField(
              label: 'password',
              hint: 'password',
              obscureText: true,
              onChanged: ref.read(loginFormProvider.notifier).onPasswordChange,
              errorMsg: loginForm.isFormPosted
                  ? loginForm.password.errorMessage
                  : null,
              prefixIcon: const Icon(Icons.password_outlined),
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
                  loginForm.isPosting 
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      texto: 'Ingresar',
                      onTap: loginForm.isPosting 
                        ? null
                        :  ref.read(loginFormProvider.notifier).onFormSubmit,
                    ),
                  // CustomButton(
                  //   texto: 'Regresar',
                  //   onTap: () {},
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
