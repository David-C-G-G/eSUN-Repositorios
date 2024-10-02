// import 'package:esun/presentacion/blocs/auth/auth_cubit.dart';
// import 'package:esun/presentacion/blocs/blocs.dart';
// import 'package:esun/presentacion/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class RegisterScreen extends StatelessWidget {

//   static const String name = 'RegisterScreen';

//   const RegisterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Nuevo usuario'),
//       ),
//       body: const _RegisterView(),
//     );
//   }
// }

// class _RegisterView extends StatelessWidget {
//   const _RegisterView();

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => RegisterCubit(),
//       child: const SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 FlutterLogo(size: 100,),
      
//                 _RegisterForm(),
      
//                 // const CustomForm(),
      
//                 SizedBox(height: 20,),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _RegisterForm extends StatelessWidget {
//   const _RegisterForm();

//   @override
//   Widget build(BuildContext context) {

//     final registerCubit = context.watch<RegisterCubit>();

//     final username = registerCubit.state.userName;
//     final password = registerCubit.state.password;
//     final email    = registerCubit.state.email;

//     return Form(
//       child: Column(
//         children: [

//           CustomFormField(
//             label: 'nombre de usuario',
//             onChanged: registerCubit.userName,
//             errorMsg: username.errorMessage,
//           ),

//           const SizedBox(height: 10,),

//           CustomFormField(
//             label: 'email',
//             onChanged: registerCubit.email,
//             errorMsg: email.errorMessage,
//           ),

//           const SizedBox(height: 10,),

//           CustomFormField(
//             label: 'password: ${password.value} ',
//             obscureText: true,
//             onChanged: registerCubit.password,
//             errorMsg: password.errorMessage,
//           ),

//           const SizedBox(height: 20,),

//           CustomButton(
//             texto: 'Guardar',
//             onTap: (){
//               registerCubit.onSubmit();
//             },
//           ),

//         ],
//       ),
//     );
//   }
// }