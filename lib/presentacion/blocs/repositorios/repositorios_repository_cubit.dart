import 'package:esun/infrastructure/features/infraestructure/infraestructure.dart';
import 'package:esun/presentacion/blocs/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'repositorio_repository_state.dart';

class RepositoriosRepositoryCubit extends Cubit<RepositoriosRepositoryState> {

  RepositoriosRepositoryImpl? repositoriosRepository;

  RepositoriosRepositoryCubit
  (AuthCubit authCubit) : super(const RepositoriosRepositoryState()){
    authCubit.stream.listen((authState) {
      final accessToken = authState.user?.token ?? '';
      repositoriosRepository = RepositoriosRepositoryImpl(RepositoriosDatasourceImpl(accessToken: accessToken));
      emit(state);
    });
  }

  
}
