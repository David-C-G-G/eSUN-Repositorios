// import 'package:esun/infrastructure/inputs.dart';
import 'package:esun/infrastructure/inputs.dart';
import 'package:esun/presentacion/blocs/auth/auth_cubit.dart';
import 'package:esun/presentacion/blocs/blocs.dart';
import 'package:esun/presentacion/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  static const String name = 'RegisterScreen';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const _RegisterUser(),
    );
  }
}

// ----------

class _RegisterUser extends StatelessWidget {
  const _RegisterUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(6, 20, 68, 1),
      body: SafeArea(
        child: Padding(
          // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if(state.errorMessage.isNotEmpty){
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.black),
                    ),
                    duration: const Duration(seconds: 1),
                    backgroundColor: Colors.amber,
                  )
                );
                context.read<AuthCubit>().registrationError('');
              }
              if(state.authStatus == AuthStatus.registered){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Registro exitoso!',
                      style: TextStyle(color: Colors.black),
                    ),
                    duration: Duration(seconds: 1),
                    backgroundColor: Colors.green,
                  )
                );

                
                // resetea el formulario
                context.read<RegisterCubit>().resetForm();

                // redirige a la ruta señalada
                context.pushReplacement('/');
              //  Navigator.of(context).pushReplacementNamed('/');
              }
            },
            child: const SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LogoWidget(),
                  _RegisterFormField(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterFormField extends StatelessWidget {
  const _RegisterFormField();

  @override
  Widget build(BuildContext context) {
    final sendEmail = EmailSender();
    final registerCubit = context.watch<RegisterCubit>();
    final authCubit = context.watch<AuthCubit>();

    final username = registerCubit.state.userName;
    final email = registerCubit.state.email;
    final password = registerCubit.state.password;
    final isSubmitting =
        registerCubit.state.formStatus == FormStatus.validating;

    return BlocListener<RegisterCubit, RegisterFormState>(
      listener: (context, state) {
        if (state.formStatus == FormStatus.valid) {
          showSnackbar(context, 'Registro exitoso');
          context.pushReplacement('/');
        } else 
        if (state.formStatus == FormStatus.invalid) {
          if (authCubit.state.errorMessage.isNotEmpty) {
            showSnackbar(context, 'Error en el registro');
            authCubit.registrationError('');
          }
        }

        // manejando el error de AuthCubit
        if (authCubit.state.errorMessage.isEmpty &&
            authCubit.state.authStatus == AuthStatus.notAuthenticated) {
          showSnackbar(context, authCubit.state.errorMessage);
          authCubit.registrationError('');
        }
      },
      child: Form(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomFormField(
              label: 'nombre de usuario',
              onChanged: (value) {
                registerCubit.userName(value);
              },
              color: 'blanco',
              errorMsg: username.errorMessage,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomFormField(
              label: 'email ',
              onChanged: (value) {
                registerCubit.email(value);
              },
              color: 'blanco',
              errorMsg: email.errorMessage,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomFormField(
              label: 'password ',
              obscureText: true,
              onChanged: registerCubit.password,
              color: 'blanco',
              errorMsg: password.errorMessage,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              child: Text(
                '¿Eres Docente?',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const _IsDocente(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  texto: isSubmitting ? 'Registrando...' : 'Registrar',
                  onTap: isSubmitting 
                      ? null // Deshabilitar el botón si está enviando
                      : () async {

                          registerCubit.onSubmit();

                          if(registerCubit.state.formStatus == FormStatus.valid){
                            final email = registerCubit.state.email.value;
                            final usuario = registerCubit.state.userName.value;
                            await sendEmail.sendMail(email: email, usuario: usuario);
                            print('correo enviado..');
                          }
                        },
                ),
                CustomButton(
                  texto: ' Regresar  ',
                  onTap: () {
                    context.pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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

class _IsDocente extends StatefulWidget {
  const _IsDocente();

  @override
  State<_IsDocente> createState() => __IsDocenteState();
}

class __IsDocenteState extends State<_IsDocente> {
  bool isDocente = false;

  @override
  Widget build(BuildContext context) {
    final subRegisterCubit = context.watch<RegisterCubit>();
    final cedula = subRegisterCubit.state.cedula;

    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Switch(
          value: isDocente,
          activeColor: Colors.cyan,
          onChanged: (value) {
            setState(() {
              isDocente = value;
              // print('switch valor: $value');
            });
          },
        ),
        if (isDocente)
          SizedBox(
            height: 100,
            width: size.width,
            child: CustomFormField(
              label: 'Cédula profesional',
              onChanged: (value) {
                subRegisterCubit.cedula(value);
              },
              color: 'blanco',
              errorMsg: cedula.errorMessage,
            ),
          ),
      ],
    );
  }
}
