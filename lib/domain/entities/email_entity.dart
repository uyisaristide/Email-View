class EmailEntity {
  final String senderName;
  final String senderEmail;
  final String subject;
  final String body;
  final List<int> imageBytes;
  final String bodyHash;
  final String imageHash;

  EmailEntity({
    required this.senderName,
    required this.senderEmail,
    required this.subject,
    required this.body,
    required this.imageBytes,
    required this.bodyHash,
    required this.imageHash,
  });
}
