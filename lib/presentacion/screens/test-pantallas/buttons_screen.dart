import 'package:esun/presentacion/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonsScreen extends StatelessWidget {

  static const String name = 'buttons_screen';


  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons Screen'),
      ),
      body: const _ButtonsView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () => context.pop()
      ),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  const _ButtonsView();

  @override
  Widget build(BuildContext context) {


    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity, //usamos esta propiedad de sizedbox para poder alinear los botones al centro
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          children: [
      
            ElevatedButton(
              onPressed: (){}, 
              child: const Text('Elevated')
            ),
      
            const ElevatedButton(
              onPressed: null, 
              child: Text('Elevated Disabled')
            ),
      
            ElevatedButton.icon(
              onPressed: (){}, 
              icon: const Icon(Icons.add_a_photo_outlined),
              label: const Text('Elevated button icon'),
            ),

            FilledButton(
              onPressed: (){}, 
              child: const Text('Filled button')
            ),

            FilledButton.icon(
              onPressed: (){}, 
              icon: const Icon(Icons.account_balance_outlined),
              label: const Text('filled button icon'),
            ),

            OutlinedButton(
              onPressed: (){}, 
              child: const Text('Outlined button')
            ),

            OutlinedButton.icon(
              onPressed: (){}, 
              label: const Text('Outlined button icon'),
              icon: const Icon(Icons.wysiwyg_outlined),
            ),

            TextButton(onPressed: (){}, child: const Text('Text button')),

            TextButton.icon(
              onPressed: (){}, 
              label: const Text('Text button icon'),
              icon: const Icon(Icons.account_box_outlined),
            ),

            IconButton(onPressed: (){}, icon: const Icon(Icons.app_registration_rounded)),

            IconButton.filled(onPressed: () {}, icon: const Icon(Icons.track_changes_rounded), ),

            IconButton.filled(
              onPressed: () {}, 
              icon: const Icon(Icons.credit_card_rounded), 
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(colors.primary),
              ),
            ),

            const CustomButton(texto: 'Hola'),

      
          ],
        ),
      ),
    );
  }
}

