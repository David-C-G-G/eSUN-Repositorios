// import 'package:esun/presentacion/blocs/auth/auth_cubit.dart';
import 'package:esun/presentacion/providers/auth_provider.dart';
import 'package:esun/presentacion/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OptionScreen extends StatelessWidget {

  static const String name = 'OptionScreen';

  const OptionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Opciones', style: TextStyle(color: Colors.white, ),),

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
                
              const SizedBox(height: 40,),
        
              const _CustomOptions(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomOptions extends ConsumerWidget {
  const _CustomOptions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Column(
        children: [
      
          CustomButton(
            texto: 'Buscar Repositorio',
            onTap: (){
              context.push('/searchRepositorio');
            },
          ),
      
          const SizedBox(height: 40,),
      
          CustomButton(
            texto: 'Crear Repositorio',
            onTap: () {
              context.push('/createRepositorio');
            },
          ),
          
          const SizedBox(height: 40,),
          // const Spacer(flex: 1,), // ! no poner spacer

          CustomButton(
            texto: 'Cerrar Sesion',
            onTap: () {
              // cerrarSesion.logout();
              ref.read(authProvider.notifier).logout();
              // context.pop();
            },
          ),
          
          const SizedBox(height: 20,),
        ],
      );
  }
}