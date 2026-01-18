import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/errors/email_exceptions.dart';
import '../models/protos/email.pb.dart';

class EmailLocalDataSource {
  Future<EmailMessage> loadEmailFromAssets() async {
    try {
      final byteData = await rootBundle.load('assets/sample_email.pb');
      final bytes = byteData.buffer.asUint8List();

      if (bytes.isEmpty) {
        throw EmailParseException("Email file is empty or corrupted.");
      }

      final email = EmailMessage.fromBuffer(bytes);

      if (email.body.isEmpty || email.bodyHash.isEmpty) {
        throw EmailIntegrityException("Email body or hash missing.");
      }

      if (email.attachedImage.isEmpty || email.imageHash.isEmpty) {
        throw EmailIntegrityException("Image or image hash missing.");
      }

      return email;
    } on FlutterError {
      throw EmailFileNotFoundException("sample_email.pb not found in assets.");
    } catch (e) {
      throw EmailParseException("Failed to parse email file: $e");
    }
  }
}

