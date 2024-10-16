
import 'package:formz/formz.dart';

// Define una enumeracion de entrada para validar errores
enum DocenteError { empty }

// Extiende de Formzinput y proveee de un tipo de entrada y un tipo de error
class Docente extends FormzInput<String, DocenteError> {

  //  Llama a super.pure para representar a un modificador de tipo form input (puro)
  const Docente.pure() : super.pure('');


  // Llama a super.dirty para representar un modificador de tipo form input (sucio)
  const Docente.dirty(String value) : super.dirty(value);

  // Este método fue creado para ser llamado directamente desde donde se usará por ejemplo: email.errorMessage
  String? get errorMessage{
    if( isValid || isPure ) return null;

    if( displayError == DocenteError.empty) return 'El campo es requerido';

    return null;
  }


  // Reescribe el validador de ayuda validando un tipo de valor de entrada dado.
  @override
  DocenteError? validator(String value) {

    if( value.isEmpty || value.trim().isEmpty ) return DocenteError.empty;

    return null;
  }
}