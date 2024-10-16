part of 'repositorio_cubit.dart';

class RepositorioState extends Equatable {

  final String id;
  final Repositorio? repositorio;
  final bool isLoading;
  final bool isSaving;

  const RepositorioState({
    required this.id, 
    this.repositorio, 
    this.isLoading = true, 
    this.isSaving = false,
  });

  RepositorioState copyWith({
    String? id,
    Repositorio?  repositorio,
    bool? isLoading,
    bool? isSaving,
  }) => RepositorioState(
    id: id ?? this.id,
    repositorio: repositorio ?? this.repositorio,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );

  @override
  List<Object?> get props => [id, repositorio, isLoading, isSaving];
}
