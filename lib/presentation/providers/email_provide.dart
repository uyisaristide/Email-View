import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasoutces/email_local_datasouce.dart';
import '../../data/repositories/email_repository_impl.dart';
import '../../domain/entities/email_entity.dart';

final emailProvider = FutureProvider<EmailEntity>((ref) async {
  await Future.delayed(const Duration(seconds:1 ));

  final repo = EmailRepositoryImpl(EmailLocalDataSource());
  return repo.loadEmail();
});
