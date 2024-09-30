import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:esun/config/config.dart';
import 'package:esun/presentacion/blocs/blocs.dart';
import 'package:esun/presentacion/blocs/login/login_cubit.dart';
import 'presentacion/blocs/auth/auth_cubit.dart';


void main() async {
  await Environment.initEnvironment();
  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit(),),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
          create: (context) => LoginCubit(BlocProvider.of<AuthCubit>(context))
        ),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 0, isDarkmode: false).getTheme(),
      routerConfig: appRouter,
    );
  }
}