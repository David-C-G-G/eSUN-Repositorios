
import 'package:esun/infrastructure/features/domain/domain.dart';
import 'package:flutter/material.dart';

class RepositorioCard extends StatelessWidget {

  final Repositorio repositorio;

  const RepositorioCard({
    super.key,
    required this.repositorio
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ImageViewer(archivos: repositorio.archivoComprimido,),

        Text( repositorio.title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 10) ),
        Text( repositorio.materia, textAlign: TextAlign.center ,style: const TextStyle(color: Color.fromARGB(255, 133, 133, 133), fontSize: 10) ),
        Text( repositorio.docente, textAlign: TextAlign.center ,style: const TextStyle(color: Color.fromARGB(255, 0, 113, 243), fontSize: 10) ),
        const SizedBox(height: 20,)
      ],
    );
  }
}

class _ImageViewer extends StatelessWidget {

  final List<String> archivos;

  const _ImageViewer({required this.archivos});

  @override
  Widget build(BuildContext context) {
    
    if ( archivos.isEmpty){
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network('https://cdn-icons-png.flaticon.com/512/17443/17443920.png', 
          fit: BoxFit.cover,
          height: 150,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: FadeInImage(
        fit: BoxFit.cover,
        height: 150,
        fadeOutDuration: const Duration(milliseconds: 100),
        fadeInDuration: const Duration(milliseconds: 200),
        image: NetworkImage(archivos.first),
        placeholder: const AssetImage('assets/bottle-loader.gif'), 
      ),
    );

  }
}