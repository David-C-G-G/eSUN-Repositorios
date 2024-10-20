

// import 'package:esun/config/config.dart';
import 'package:esun/infrastructure/features/domain/domain.dart';
import 'package:esun/infrastructure/infraestructure.dart';

class RepositorioMapper {


  static jsonToEntity( Map<String, dynamic> json ) => Repositorio(
    id: json['id'],
    title: json['title'],
    docente: json['docente'],
    materia: json['materia'],
    seccion: int.parse(json['seccion'].toString()),
    anotacion: json['anotacion'],
    comentario: json['comentario'],
    // cu: json['cu'],
    tt: json['tt'],
    archivoComprimido: List<String>.from(
      json['archivoComprimido'].map( 
        (archivo) => archivo.startsWith('http')
        ? 'https://cdn-icons-png.flaticon.com/512/17443/17443920.png'
        : 'https://cdn-icons-png.flaticon.com/512/8629/8629976.png',
        // ? archivo
        // : '${ Environment.apiUrl }/files/repositorio/$archivo',
      )
    ),
    user: UserMapper.userJsonToEntity(json['user']) 
  );
}