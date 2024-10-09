
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';
import 'package:resend/resend.dart';


class EmailSender {
  
  Future<void> sendEmail(String destino, String nombre) async {
    Resend(apiKey: "re_RHZGLmgx_J4zzKtct7zu84TCiqFgc2H6u");

    try {
      final resend = Resend.instance;
      resend.sendEmail(
      from: 'davcogut@gmail.com', 
      to: [destino] , 
      subject: 'Prueba de envio de correo',
      text: 'si recibiste esto es por que funciona'
      );
    } catch (e) {
      print('email no enviado $e');
    }
    
    // String username = dotenv.env['OUTLOOK_EMAIL'] ?? '';
    // String password = dotenv.env['OUTLOOK_PASSWORD'] ?? '';

    // final smtpServer = SmtpServer('smtp-mail.outlook.com',
    //   username: username,
    //   password: password,
    //   port: 587,
    //   ignoreBadCertificate: true,
    //   ssl: false
    // );
    // final message = Message()
    //   ..from = Address(username, 'eSUN')
    //   ..recipients.add(destino)
    //   ..subject = 'Bienvenido(a) a eSUN'
    //   ..text = "$nombre, te damos la bienvenida a esta herramienta de aprendizaje, deseando que sea de utilidad durante tu estancia en la FCC";

    // try {
    //   final  sendEmail = await send(message, smtpServer);
    //   print('Correo enviado: ${sendEmail.toString()}');   
    // } catch (e) {
    //   print('Error al enviar el correo: $e');
    // }
  }
}