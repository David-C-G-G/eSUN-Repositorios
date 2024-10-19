



import 'package:esun/presentacion/providers/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterNotifierProvider = Provider((ref){
  final authNotifier = ref.read( authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

//5:38

class GoRouterNotifier extends ChangeNotifier{
  
  final AuthNotifier _authNotifier;

  AuthStatus _authStatus = AuthStatus.checking;

  GoRouterNotifier(this._authNotifier){
    _authNotifier.addListener((state){
      authStatus = state.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus( AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}