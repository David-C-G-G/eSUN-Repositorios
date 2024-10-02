import 'package:esun/presentacion/blocs/auth/auth_cubit.dart';
import 'package:esun/presentacion/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OptionScreen extends StatelessWidget {

  static const String name = 'OptionScreen';

  const OptionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Busqueda de repositorios', style: TextStyle(color: Colors.white, ),),

      ),    
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
        
              const SizedBox(height: 50,),
        
              SizedBox(
                  // height: 100,
                  width: 150,
                  child: Image.asset('assets/escudo.png'),
                ),
        
              const SizedBox(height: 30,),
          
              const Text('¿Deseas buscar por?', style: TextStyle(color: Colors.white, fontSize: 25 ),),
        
              const SizedBox(height: 30,),
        
              const _CustomOptions(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomOptions extends StatelessWidget {
  const _CustomOptions();

  @override
  Widget build(BuildContext context) {

    final cerrarSesion = context.watch<AuthCubit>();

    return Column(
        children: [
      
          CustomButton(
            texto: 'Docentes',
            onTap: (){
              context.push('/docentes');
            },
          ),
      
          const SizedBox(height: 20,),
      
          CustomButton(
            texto: 'Materia',
            onTap: () {
              context.push('/materias');
            },
          ),
          
          const SizedBox(height: 20,),

          CustomButton(
            texto: 'Cerrar Sesion',
            onTap: () {
              cerrarSesion.logout();
              context.pop();
            },
          ),
          
          const SizedBox(height: 20,),
        ],
      );
  }
}