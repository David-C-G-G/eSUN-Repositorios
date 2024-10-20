import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:esun/infrastructure/features/domain/domain.dart';
import 'package:esun/presentacion/providers/providers.dart';
import 'package:esun/presentacion/widgets.dart';

class RepositorioScreen extends ConsumerWidget {
  static const String name = 'RepositorioScreen';
  final String repositorioId;
  const RepositorioScreen({super.key, required this.repositorioId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final repositorioState = ref.watch( repositorioProvider(repositorioId));

    return Scaffold(
        appBar: AppBar(
          title: const Text('Editar Repositorio'),
          actions: [
            IconButton(
              onPressed: () {}, 
              icon: const Icon(Icons.file_upload))
          ],
        ),
        body: repositorioState.isLoading
          ? const FullScreenLoader()
          : _RepositorioView(repositorio: repositorioState.repositorio!),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.save_as_outlined),
        ),
      );
  }
}


class _RepositorioView extends StatelessWidget {
  final Repositorio repositorio;
  const _RepositorioView({required this.repositorio});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                width: 600,
                child: _ArchivoGallery(archivos: repositorio.archivoComprimido),
              ),
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
                label: 'Tecnologías:',
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
