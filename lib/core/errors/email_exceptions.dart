class EmailFileNotFoundException implements Exception {
  final String message;
  EmailFileNotFoundException(this.message);
}

class EmailParseException implements Exception {
  final String message;
  EmailParseException(this.message);
}

class EmailIntegrityException implements Exception {
  final String message;
  EmailIntegrityException(this.message);
}
