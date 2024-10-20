
import 'package:formz/formz.dart';

// Define una enumeracion de entrada para validar errores
enum TipoTrabajoError { empty, format }

// Extiende de Formzinput y proveee de un tipo de entrada y un tipo de error
class TipoTrabajo extends FormzInput<String, TipoTrabajoError> {

  //  Llama a super.pure para representar a un modificador de tipo form input (puro)
  const TipoTrabajo.pure() : super.pure('');


  // Llama a super.dirty para representar un modificador de tipo form input (sucio)
  const TipoTrabajo.dirty({String value = ''}) : super.dirty(value);

  // Este método fue creado para ser llamado directamente desde donde se usará por ejemplo: email.errorMessage
  String? get errorMessage{
    if( isValid || isPure ) return null;

    if( displayError == TipoTrabajoError.empty) return 'El campo es requerido';

    return null;
  }


  // Reescribe el validador de ayuda validando un tipo de valor de entrada dado.
  @override
  TipoTrabajoError? validator(String value) {

    if( value.toString().isEmpty || value.toString().trim().isEmpty ) return TipoTrabajoError.empty;

    return null;
  }
}