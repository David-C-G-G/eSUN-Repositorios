
import 'package:formz/formz.dart';

// Define una enumeracion de entrada para validar errores
enum CedulaError { length }

// Extiende de Formzinput y proveee de un tipo de entrada y un tipo de error
class Cedula extends FormzInput<String, CedulaError> {

  
  //  Llama a super.pure para representar a un modificador de tipo form input (puro)
  const Cedula.pure() : super.pure('');


  // Llama a super.dirty para representar un modificador de tipo form input (sucio)
  const Cedula.dirty({String value = ''}) : super.dirty(value);

  // Este método fue creado para ser llamado directamente desde donde se usará por ejemplo: username.errorMessage
  String? get errorMessage{
    if( isValid || isPure ) return null;
    // if( displayError == CedulaError.empty) return 'El campo no puede ser vacío';
    if( displayError == CedulaError.length) return 'La cédula debe contener 7 u 8 caracteres';

    return null;
  }


  // Reescribe el validador de ayuda validando un tipo de valor de entrada dado.
  @override
  CedulaError? validator(String value) {

    if(value.isEmpty) return null;
    // if( value.isEmpty || value.trim().isEmpty ) return CedulaError.empty;
    if( value.length < 7 || value.length > 8 ) return CedulaError.length;


    return null;
  }
}