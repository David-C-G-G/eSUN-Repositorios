import 'dart:io';

import 'package:esun/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:esun/infrastructure/features/domain/domain.dart';
import 'package:esun/presentacion/providers/providers.dart';
import 'package:esun/presentacion/widgets.dart';

class RepositorioScreen extends ConsumerWidget {

  static const String name = 'RepositorioScreen';
  final String repositorioId;
  
  const RepositorioScreen({super.key, required this.repositorioId});

  void showSnackbar( BuildContext context ){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Repositorio Actualizado'))
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final repositorioState = ref.watch( repositorioProvider(repositorioId));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Editar Repositorio'),
            actions: [
              IconButton(
                onPressed: () async {
                  final photoPath = await CameraGalleryServiceImpl().selectPhoto();
                  if(photoPath == null) return;

                  ref.read(repositorioFormProvider(repositorioState.repositorio!).notifier)
                    .updateProduct(photoPath);
                  // photoPath;
                }, 
                icon: const Icon(Icons.file_upload)),
              IconButton(
                onPressed: () async {
                  final photoPath = await CameraGalleryServiceImpl().takePhoto();
                  if(photoPath == null) return;

                  ref.read(repositorioFormProvider(repositorioState.repositorio!).notifier)
                    .updateProduct(photoPath);
                  // photoPath;
                }, 
                icon: const Icon(Icons.camera_alt_outlined))
            ],
          ),
          body: repositorioState.isLoading
            ? const FullScreenLoader()
            : ListView(
              children: [
                const SizedBox(height: 10),
                _RepositorioView(repositorio: repositorioState.repositorio!),
              ],
            ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {

              FocusScope.of(context).unfocus();
              if (repositorioState.repositorio == null) return;
      
              ref.read(
                repositorioFormProvider(repositorioState.repositorio!).notifier
              ).onRepositorioFormSubmit()
                .then((value){
                  if(!value) return;
                  showSnackbar(context);
                });
            },
            child: const Icon(Icons.save_as_outlined),
          ),
        ),
    );
  }
}


class _RepositorioView extends ConsumerWidget {
  final Repositorio repositorio;
  const _RepositorioView({required this.repositorio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final repositorioForm = ref.watch(repositorioFormProvider(repositorio));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            width: 600,
            child: _ArchivoGallery(archivos: repositorioForm.archivoComprimido),
            // child: _ArchivoGallery(archivos: repositorio.archivoComprimido),
          ),
          const SizedBox(height: 10),
          Center(child: Text(repositorioForm.title.value, style: const TextStyle(fontSize: 25, color: Colors.white ))),
          const SizedBox(height: 10),
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
            initialValue: repositorioForm.title.value,
            onChanged: ref.read(repositorioFormProvider(repositorio).notifier).onTitleChanged,
            errorMessage: repositorioForm.title.errorMessage,
          ),
          // const SizedBox(height: 15),
          CustomRepositorioField(
            label: 'Docente:',
            initialValue: repositorioForm.docente.value,
            onChanged: ref.read(repositorioFormProvider(repositorio).notifier).onDocenteChanged,
            errorMessage: repositorioForm.docente.errorMessage,
          ),
          // const SizedBox(height: 15), 4:25
          CustomRepositorioField(
            label: 'Materia:',
            initialValue: repositorioForm.materia.value,
            onChanged: ref.read(repositorioFormProvider(repositorio).notifier).onMateriaChanged,
            errorMessage: repositorioForm.materia.errorMessage,
          ),
          // const SizedBox(height: 15),
          CustomRepositorioField(
            label: 'Seccion:',
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            initialValue: repositorioForm.seccion.toString(),
            onChanged: (value) 
              => ref.read(repositorioFormProvider(repositorio).notifier)
                  .onSeccionChanged(int.tryParse(value) ?? 1
                ),
          ),
          // const SizedBox(height: 15),
          CustomRepositorioField(
            label: 'Tecnologías:',
            hint: 'agrega la tecnología usada',
            initialValue: repositorioForm.anotacion,
            onChanged: ref.read(repositorioFormProvider(repositorio).notifier).onAnotacionChanged,
          ),
          // const SizedBox(height: 15),
          CustomRepositorioField(
            isBottomField: true,
            label: 'Tipo de Trabajo:',
            initialValue: repositorio.tt,
            onChanged: ref.read(repositorioFormProvider(repositorio).notifier).onTipoTrabajoChanged,
            errorMessage: repositorioForm.tt.errorMessage,
          ),
          const SizedBox(height: 15),
          CustomRepositorioField(
            isTopField: true,
            isBottomField: true,
            maxLines: 6,
            label: 'Comentarios',
            keyboardType: TextInputType.multiline,
            initialValue: repositorioForm.comentario,
            onChanged: ref.read(repositorioFormProvider(repositorio).notifier).onComentarioChanged,
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

    if( archivos.isEmpty ){
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Image.asset('assets/no-image.png', fit: BoxFit.cover,),
      );
    }


    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(viewportFraction: 0.7),
      children: archivos.map((item) {

              late ImageProvider imageProvider;

              if(item.startsWith('http')){
                imageProvider = NetworkImage(item);
              }else{
                imageProvider = FileImage(File(item));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    image: imageProvider,
                    placeholder: const AssetImage('assets/bottle-loader.gif'), 
                  )
                ),
              );
            }).toList(),
    );
  }
}
