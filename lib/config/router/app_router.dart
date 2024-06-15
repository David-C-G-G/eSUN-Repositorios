

import 'package:esun/presentacion/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes:[

  GoRoute(
    name: HomeScreen.name,
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),

  GoRoute(
    name: ButtonsScreen.name,
    path: '/buttons',
    builder: (context, state) => const ButtonsScreen(),
  ),

  GoRoute(
    name: RegisterScreen.name,
    path: '/formularios',
    builder: (context, state) => const RegisterScreen(),
  ),

]);