
import 'package:formz/formz.dart';

// Define una enumeracion de entrada para validar errores
enum PasswordError { empty, length }

// Extiende de Formzinput y proveee de un tipo de entrada y un tipo de error
class Password extends FormzInput<String, PasswordError> {

  
  //  Llama a super.pure para representar a un modificador de tipo form input (puro)
  const Password.pure() : super.pure('');


  // Llama a super.dirty para representar un modificador de tipo form input (sucio)
  const Password.dirty({String value = ''}) : super.dirty(value);

  // Este método fue creado para ser llamado directamente desde donde se usará por ejemplo: password.errorMessage
  String? get errorMessage{
    if( isValid || isPure ) return null;

    if( displayError == PasswordError.empty) return 'El campo es requerido';
    if( displayError == PasswordError.length) return 'Mínimo 8 caracteres';

    return null;
  }


  // Reescribe el validador de ayuda validando un tipo de valor de entrada dado.
  @override
  PasswordError? validator(String value) {


    if( value.isEmpty || value.trim().isEmpty ) return PasswordError.empty;
    if( value.length < 8 ) return PasswordError.length;


    return null;
  }
}