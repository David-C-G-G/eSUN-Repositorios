

import 'package:esun/presentacion/pantallas.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes:[

  GoRoute(
    name: HomeScreen.name,
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),

  GoRoute(
    name: LoginScreen.name,
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),

  GoRoute(
    name: RegisterScreen.name,
    path: '/register',
    builder: (context, state) => const RegisterScreen(),
  ),

  GoRoute(
    name: OptionScreen.name,
    path: '/option',
    builder: (context, state) => const OptionScreen(),
  ),

  GoRoute(
    name: DocentesScreen.name,
    path: '/docentes',
    builder: (context, state) => const DocentesScreen(),
  ),

  GoRoute(
    name: MateriasScreen.name,
    path: '/materias',
    builder: (context, state) => const MateriasScreen(),
  ),

]);