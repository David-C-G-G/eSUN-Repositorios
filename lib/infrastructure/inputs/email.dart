//r'^[\w-\.]+@([\w-]\.)+[\w-]{2,4}$'
//r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'

import 'package:formz/formz.dart';

// Define una enumeracion de entrada para validar errores
enum EmailError { empty, format }

// Extiende de Formzinput y proveee de un tipo de entrada y un tipo de error
class Email extends FormzInput<String, EmailError> {

  // Compartir la expresión regular de formato de correo
  static final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  
  //  Llama a super.pure para representar a un modificador de tipo form input (puro)
  const Email.pure() : super.pure('');


  // Llama a super.dirty para representar un modificador de tipo form input (sucio)
  const Email.dirty({String value = ''}) : super.dirty(value);

  // Este método fue creado para ser llamado directamente desde donde se usará por ejemplo: email.errorMessage
  String? get errorMessage{
    if( isValid || isPure ) return null;

    if( displayError == EmailError.empty) return 'El campo es requerido';
    if( displayError == EmailError.format) return 'No tiene formato de email';

    return null;
  }


  // Reescribe el validador de ayuda validando un tipo de valor de entrada dado.
  @override
  EmailError? validator(String value) {

    if( value.isEmpty || value.trim().isEmpty ) return EmailError.empty;
    if( !emailRegExp.hasMatch(value)) return  EmailError.format;  


    return null;
  }
}