
import 'package:esun/infrastructure/features/infraestructure/infraestructure.dart';
import 'package:esun/presentacion/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:esun/infrastructure/features/domain/domain.dart';

final repositoriosRepositoryProvider = Provider<RepositoriosRepository>((ref) {

  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final repositoriosRepository = RepositoriosRepositoryImpl(
    RepositoriosDatasourceImpl(accessToken: accessToken)
  );

  return repositoriosRepository;
});