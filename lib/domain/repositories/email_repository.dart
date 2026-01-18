import '../entities/email_entity.dart';

abstract class EmailRepository {
  Future<EmailEntity> loadEmail();
}
