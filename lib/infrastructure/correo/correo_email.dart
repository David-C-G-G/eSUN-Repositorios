// import 'package:flutter/material.dart';
// import 'package:esun/infrastructure/inputs.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';



final smtpServer = hotmail(dotenv.env["OUTLOOK_EMAIL"]!, dotenv.env["OUTLOOK_PASSWORD"]!);

  sendMailFromOutlook( String email) async {
    final message = Message()
    ..from = Address(dotenv.env["OUTLOOK_EMAIL"]!)
    ..recipients.add(email)
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
    ..subject = 'Test de email desde eSUN'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Bienvenido(a) a eSUN</h1>\n<p>Registrado(a) correctamente</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent: $e');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}