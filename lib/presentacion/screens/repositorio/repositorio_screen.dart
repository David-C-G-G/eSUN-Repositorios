import 'package:esun/infrastructure/features/domain/domain.dart';
import 'package:esun/presentacion/blocs/blocs.dart';
import 'package:esun/presentacion/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepositorioScreen extends StatelessWidget {
  static const String name = 'RepositorioScreen';
  final String repositorioId;

  const RepositorioScreen({required this.repositorioId, super.key});

  @override
  Widget build(BuildContext context) {
    // obtenemos el RepositoriosRepositoryCubit para pasar al RepositorioCubit
    final repositoriosRepositoryCubit =
        context.read<RepositoriosRepositoryCubit>();

    return BlocProvider(
      create: (context) => RepositorioCubit(
        repositoriosRepository:
            repositoriosRepositoryCubit.repositoriosRepository!,
        repositorioId: repositorioId,
      )..loadRepositorio(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Repositorio'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.file_upload))
          ],
        ),
        // body: const RepositorioScreenBody(),
        body: BlocBuilder<RepositorioCubit, RepositorioState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const FullScreenLoader();
            }

            if (state.repositorio == null) {
              return const Center(
                child: Text('Cargando'),
              );
            }

            return _RepositorioView(repositorio: state.repositorio!);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.save_as_outlined),
        ),
      ),
    );
  }
}

class _RepositorioView extends StatelessWidget {
  final Repositorio repositorio;

  const _RepositorioView({required this.repositorio});

  @override
  Widget build(BuildContext context) {

    // final repositorioForm = context.read<RepositorioFormCubit>();

    return ListView(
      children: [
        SizedBox(
          height: 250,
          width: 600,
          child: _ArchivoGallery(archivos: repositorio.archivoComprimido),
        ),
        const SizedBox(height: 10),
        Center(
            child: Text(repositorio.title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),
        const SizedBox(height: 10),
        _ProductInformation(repositorio: repositorio),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _ProductInformation extends StatelessWidget {
  final Repositorio repositorio;
  const _ProductInformation({required this.repositorio});

  @override
  Widget build(BuildContext context) {
    // final textStyles = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Datos Repositorio',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 15),
              CustomRepositorioField(
                isTopField: true,
                label: 'Repositorio',
                initialValue: repositorio.title,
              ),
              // const SizedBox(height: 15),
              CustomRepositorioField(
                label: 'Docente:',
                initialValue: repositorio.docente,
              ),
              // const SizedBox(height: 15),
              CustomRepositorioField(
                label: 'Materia:',
                initialValue: repositorio.materia,
              ),
              // const SizedBox(height: 15),
              CustomRepositorioField(
                label: 'Seccion:',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                initialValue: repositorio.seccion.toString(),
              ),
              // const SizedBox(height: 15),
              CustomRepositorioField(
                label: 'Anotacion:',
                initialValue:
                    repositorio.anotacion ?? 'agrega una nota importante',
              ),
              // const SizedBox(height: 15),
              CustomRepositorioField(
                isBottomField: true,
                label: 'Tipo de Trabajo:',
                initialValue: repositorio.tt,
              ),
              const SizedBox(height: 15),
              CustomRepositorioField(
                isTopField: true,
                isBottomField: true,
                maxLines: 6,
                label: 'Comentarios',
                keyboardType: TextInputType.multiline,
                initialValue: repositorio.comentario ?? 'agregar comentario',
              ),
              const SizedBox(height: 100),
            ],
      )
    );
  }
}

class _ArchivoGallery extends StatelessWidget {
  final List<String> archivos;
  const _ArchivoGallery({required this.archivos});

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(viewportFraction: 0.7),
      children: archivos.isEmpty
          ? [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Image.asset('assets/no-image.png', fit: BoxFit.cover))
            ]
          : archivos.map((e) {
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  e,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
    );
  }
}
