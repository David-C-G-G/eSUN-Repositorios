
import 'package:esun/presentacion/pantallas.dart';
import 'package:esun/presentacion/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_router_notifier.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.watch(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/checkstatus',
    refreshListenable: goRouterNotifier,
    routes: [
      // Pantalla de verificación de token
      GoRoute(
        path: '/checkstatus',
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
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      // print('GoRouter authStatus: $authStatus, isGoingTo: $isGoingTo');

      // if(authStatus == AuthStatus.checking) return '/login';

      if(authStatus == AuthStatus.checking ) {
        return isGoingTo == '/checkstatus' ? null : '/checkstatus';
      }

      if( authStatus == AuthStatus.notAuthenticated ){
        if( isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }

      if(authStatus == AuthStatus.registrationSuccess){
        
        return '/login';
      }

        // print('Esto tiene mi authStatus: $authStatus');
      if( authStatus == AuthStatus.authenticated ){
        // print('Esto tiene mi authStatus: $authStatus');
        if( isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/checkstatus') return '/option';
      }

      return null;
    },
  );
});
