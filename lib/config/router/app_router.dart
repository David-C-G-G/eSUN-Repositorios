

import 'package:esun/presentacion/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes:[

  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),

  GoRoute(
    path: '/buttons',
    builder: (context, state) => const ButtonsScreen(),
  ),

]);