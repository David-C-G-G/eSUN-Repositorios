import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esun/presentacion/blocs/auth/auth_cubit.dart';
import 'package:go_router/go_router.dart';

class CheckAuthStatusScreen extends StatelessWidget {
  const CheckAuthStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state.authStatus == AuthStatus.authenticated){
          context.go('/options');
        }else if (state.authStatus == AuthStatus.notAuthenticated){
          context.go('/login');
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
