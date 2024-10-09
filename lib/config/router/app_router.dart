

import 'package:esun/presentacion/pantallas.dart';
import 'package:go_router/go_router.dart';


final appRouter = GoRouter(
  initialLocation: '/',
  routes:[
  // Pantalla de verificación de token
  GoRoute(
    path: '/splash',
    builder: (context, state) => const CheckAuthStatusScreen(),
  ),
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
    name: SeachRepositoriosScreen.name,
    path: '/searchRepositorio',
    builder: (context, state) => const SeachRepositoriosScreen(),
  ),

  GoRoute(
    name: CreateRepositoriosScreen.name,
    path: '/createRepositorio',
    builder: (context, state) => const CreateRepositoriosScreen(),
  ),

  GoRoute(
    name: RepositorioScreen.name,
    path: '/repositorio/:id',
    builder: (context, state) {
      final repositorioId = state.pathParameters['id'] ?? 'no-id';
      return RepositorioScreen(repositorioId: repositorioId);
    },
  ),

]);






