
import 'package:formz/formz.dart';

// Define una enumeracion de entrada para validar errores
enum UsernameError { empty, length }

// Extiende de Formzinput y proveee de un tipo de entrada y un tipo de error
class Username extends FormzInput<String, UsernameError> {

  
  //  Llama a super.pure para representar a un modificador de tipo form input (puro)
  const Username.pure() : super.pure('');


  // Llama a super.dirty para representar un modificador de tipo form input (sucio)
  const Username.dirty({String value = ''}) : super.dirty(value);

  // Este método fue creado para ser llamado directamente desde donde se usará por ejemplo: username.errorMessage
  String? get errorMessage{
    if( isValid || isPure ) return null;

    if( displayError == UsernameError.empty) return 'El campo es requerido';
    if( displayError == UsernameError.length) return 'Mínimo 3 caracteres';

    return null;
  }


  // Reescribe el validador de ayuda validando un tipo de valor de entrada dado.
  @override
  UsernameError? validator(String value) {


    if( value.isEmpty || value.trim().isEmpty ) return UsernameError.empty;
    if( value.length < 3 ) return UsernameError.length;


    return null;
  }
}