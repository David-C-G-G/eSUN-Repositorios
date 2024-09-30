import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:esun/presentacion/widgets.dart';
import 'package:esun/presentacion/delegates/search_docente_delegate.dart';


const cards = <String> [

  'Hola',
  'Saludos',
  '¿como estas?',
  'buenos dias',
  'buenas tardes',
  'buenas noches',
  'que tal',
  'wey',
  'que onda',
  'tanto tiempo',
  'estas ocupado(a)',
  'bien',
  'mal',
  'mas o menos',
  'ahi voy',
  'ya mero',

];

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15,15,0),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              CustomButtonImage(
                name: 'assets/regresar.png',
                onTap: () => context.pop(),
              ),

              const SizedBox(
                width: 10,
              ),
          

              const Spacer(),

              const Text('Busqueda Rápida ->', style: TextStyle(color: Colors.white, fontSize: 20),),
              // const Expanded(
              //   child: CustomFormField(
              //     hint: 'nombre',
              //     label: 'Buscar Docente',
              //     color: 'blanco',
              //   ),
              // ),
      
              const SizedBox(
                width: 10,
              ),
      
              CustomButtonImage(
                name: 'assets/buscar.png',
                onTap: (){
                  showSearch(
                    context: context, 
                    delegate: SearchDocenteDelegate()
                  );
                },
              ),
          
          
          
            ],
          ),
        ),
      )
    );
  }
}