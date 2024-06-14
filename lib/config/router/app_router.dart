

import 'package:esun/presentacion/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes:[

  GoRoute(
    name: HomeScreen.name,
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),

  GoRoute(
    path: ButtonsScreen.name,
    builder: (context, state) => const ButtonsScreen(),
  ),

]);