import '../../domain/entities/email_entity.dart';
import '../datasoutces/email_local_datasouce.dart';

class EmailRepositoryImpl {
  final EmailLocalDataSource localDataSource;

  EmailRepositoryImpl(this.localDataSource);

  Future<EmailEntity> loadEmail() async {
    final proto = await localDataSource.loadEmailFromAssets();

    return EmailEntity(
      senderName: proto.senderName,
      senderEmail: proto.senderEmailAddress,
      subject: proto.subject,
      body: proto.body,
      bodyHash: proto.bodyHash,
      imageBytes: proto.attachedImage,
      imageHash: proto.imageHash,
    );
  }
}
