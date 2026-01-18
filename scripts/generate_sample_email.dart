import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:qt_test_aristide/data/models/protos/email.pb.dart';

void main() {
  final String bodyText = '''
Dear Hiring Team,

Thank you for the opportunity to complete the take-home practical test.

This Flutter application is my implementation of the "View Email" prototype as requested. The app loads a locally stored Protocol Buffer file, decodes the email message, and verifies the integrity of both the email body and the attached image using SHA-256 hashing.

I appreciate your time and consideration, and I look forward to your feedback.

Kind regards,  
Aristide Uyisenga
''';

  final imageBytes = File('assets/test_image.png').readAsBytesSync();

  final email = EmailMessage()
    ..senderName = 'Uyisenga Aristide'
    ..senderEmailAddress = 'uyisaristide@gmail.com'
    ..subject = 'View email app submission'
    ..body = bodyText
    ..attachedImage = imageBytes
    ..bodyHash = sha256.convert(utf8.encode(bodyText)).toString()
    ..imageHash = sha256.convert(imageBytes).toString();

  final outFile = File('assets/sample_email.pb');
  outFile.writeAsBytesSync(email.writeToBuffer());

  print('sample_email.pb generated successfully!');
}
