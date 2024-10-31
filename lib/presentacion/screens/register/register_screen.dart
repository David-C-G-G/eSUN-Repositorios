import 'package:esun/presentacion/providers/providers.dart';
import 'package:esun/presentacion/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const LogoWidget(),
                const _RegisterFormField(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿Ya tienes cuenta?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () => context.push('/login'),
                        child: const Text('Inicia sesión'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterFormField extends ConsumerStatefulWidget {
  const _RegisterFormField();

  @override
 ConsumerState<_RegisterFormField> createState() => _RegisterFormFieldState();
}

class _RegisterFormFieldState extends ConsumerState<_RegisterFormField> {

  // Estado para menjar la visibilidad de la contraseña
  bool _obscurePassword = true;

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {

    final registerForm = ref.watch(registerFormProvider);

    ref.listen(authProvider, (previous, next){
      if(next.errorMessage.isEmpty) return;
      showSnackbar(context, next.errorMessage);
    });

    return Form(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomFormField(
            label: 'nombre de usuario',
            hint: 'nombre de usuario',
            onChanged: ref.read(registerFormProvider.notifier).onUserNameRegisterChange,
            prefixIcon: const Icon(Icons.account_circle_outlined),
            errorMsg: registerForm.isRegisterFormPosted ? registerForm.userName.errorMessage: null,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomFormField(
            label: 'email ',
            hint: 'email',
            onChanged: ref.read(registerFormProvider.notifier).onEmailRegisterChange,
            prefixIcon: const Icon(Icons.email_outlined),
            errorMsg: registerForm.isRegisterFormPosted ? registerForm.email.errorMessage: null,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomFormField(
            label: 'password ',
            hint: 'password',
            obscureText: _obscurePassword,
            onChanged: ref.read(registerFormProvider.notifier).onPasswordRegisterChange,
            prefixIcon: const Icon(Icons.password_outlined),
            suffixIcon: IconButton(
              iconSize: 25,
              alignment: Alignment.center,
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey, 
              ),
              onPressed: (){
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            errorMsg: registerForm.isRegisterFormPosted ? registerForm.password.errorMessage : null,
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
              registerForm.isPosting
                ? const CircularProgressIndicator()
                : CustomButton(
                  texto: 'Registrar', 
                  onTap: registerForm.isPosting
                    ? null
                    : () async {
                      
                        final result = await ref.read(registerFormProvider.notifier).onFormSubmit();
                        print(result);

                        if(mounted && result){
                          context.go('/login');
                        }else{
                          return null;
                        }

                      },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IsDocente extends ConsumerStatefulWidget {
  const _IsDocente();

  @override
  ConsumerState<_IsDocente> createState() => __IsDocenteState();
}

class __IsDocenteState extends ConsumerState<_IsDocente> {
  bool isDocente = false;

  @override
  Widget build(BuildContext context) {

    final registerCedulaForm = ref.watch(registerFormProvider);

    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Switch(
          value: isDocente,
          activeColor: Colors.cyan,
          onChanged: (value) {
            setState(() {
              isDocente = value;
              ref.read(registerFormProvider.notifier).onIsDocenteChange(isDocente);
            });
          },
        ),
        if (isDocente)
          SizedBox(
            height: 100,
            width: size.width,
            child: CustomFormField(
              label: 'Cédula profesional',
              hint: 'Cédula profesional',
              onChanged: ref.read(registerFormProvider.notifier).onCedulaRegisterChange,
              errorMsg: registerCedulaForm.isRegisterFormPosted
                ? registerCedulaForm.cedula.errorMessage
                : null,
              prefixIcon: const Icon(Icons.verified_user_outlined),
            ),
          ),
      ],
    );
  }
}
