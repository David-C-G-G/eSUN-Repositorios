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
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: const _RegisterUser(),
    );
  }
}

class _RegisterUser extends StatelessWidget {


  const _RegisterUser();

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

                _RegisterFormField(),

                SizedBox(height: 20,),

                // Row(
                  
                //   children: [
                //     SizedBox(child: Text('Eres Docente?', style: TextStyle(color: Colors.white),),),
                //     _IsDocente(),
                //   ],
                // ),

                // SizedBox(child: Text('Eres Docente?', style: TextStyle(color: Colors.white),),),
                //     _IsDocente(),

                SizedBox(height: 20,),



              ],
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

    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.userName;
    final email    = registerCubit.state.email;
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
            label: 'email ',
            onChanged: registerCubit.email,
            color: 'blanco',
            errorMsg: email.errorMessage,
          ),

          const SizedBox(height: 20,),

          CustomFormField(
            label: 'password ',
            obscureText: true,
            onChanged: registerCubit.password,
            color: 'blanco',
            errorMsg: password.errorMessage,
          ),     

          const SizedBox(height: 20,),

          const SizedBox(child: Text('¿Eres Docente?', style: TextStyle(color: Colors.white),),),

          const _IsDocente(),

          // const SizedBox(height: 40,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                texto: 'Registrar',
                onTap: (){
                  registerCubit.onSubmit();
                },
              ),

              CustomButton(
                texto: ' Regresar  ',
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

class _IsDocente extends StatefulWidget {
  const _IsDocente();

  @override
  State<_IsDocente> createState() => __IsDocenteState();
}

class __IsDocenteState extends State<_IsDocente> {
  bool isDocente = false;

  void updateValue(bool newValue){
    setState(() {
      isDocente = newValue;
    });
  }
  
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
    
        isDocente 
          ? SizedBox(
            height: 100,
            width: size.width,
            child: CustomFormField(
              label: 'Cédula profesional',
              onChanged: subRegisterCubit.cedula,
              color: 'blanco',
              errorMsg: cedula.errorMessage,
              ) ,
          )
          : const SizedBox(),
      ],
    );
  }
}