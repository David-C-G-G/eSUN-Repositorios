
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailSender{

  Future<bool> sendMail({
    required String email,
    required String usuario,
    // required String message,
  }) async {
    String username = dotenv.env['GMAIL_EMAIL'] ?? '';
    String password = dotenv.env['GMAIL_PASSWORD'] ?? '';

    print('Email: $username, Password: $password');
    final smtpServer = gmail(username, password);
    final messagedata = Message()
      ..from = Address(username, 'LeadingSoftware')
      .. recipients.add(email)
      ..subject = 'Mail'
      ..text = '''
      Registrado(a) correctamente!

        $usuario bienvenido(a) a la aplicación movil eSUN,
        deseamos que esta herramienta te sea de mucha ayuda! :D

      atte: LeadingSoftware
      ''';

    try {
      await send(messagedata, smtpServer);
      return true;
    } catch (e) {
      print('Email no enviado: $e');
      return false;
    }
  }
}
