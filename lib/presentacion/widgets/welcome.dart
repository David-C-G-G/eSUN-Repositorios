import 'package:esun/presentacion/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromRGBO(6, 20, 68, 1),
      body: Center(
        // child: Escudo(),
        child: Container(
          decoration: const BoxDecoration(
            color:Color.fromARGB(40, 22, 114, 170),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          width: 300,
          height: 500.0,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(16),

          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                height: 100,
                width: 150,
                child: Image.asset('assets/escudo.png'),
              ),

              const SizedBox(
                height: 20,
              ),

              CustomButton(
                texto: 'Iniciar Sesión',
                onTap: (){
                  context.push('/login');
                },
              ),

              const SizedBox(
                height: 20,
              ),
      
              CustomButton(
                texto: 'Registrarse',
                onTap: (){
                  context.push('/register');
                },
              ),
            ],
          ),
        ),
  
      ),
    );
  }
}