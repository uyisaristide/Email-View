import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utls/hash_utls.dart';
import '../providers/email_provide.dart';
import '../providers/theme_provider.dart';
import '../widgets/verification_badge.dart';

class EmailViewScreen extends ConsumerWidget {
  const EmailViewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailAsync = ref.watch(emailProvider);
    final isDark = ref.watch(themeProvider);
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,

        scrolledUnderElevation: 0,
        elevation: 0,
        actions: [
          IconButton(
            icon: isDark
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
            onPressed: () {
              ref.read(themeProvider.notifier).state = !ref
                  .read(themeProvider.notifier)
                  .state;
            },
          ),
          IconButton(icon: const Icon(Icons.delete_outline), onPressed: () {}),
        ],
      ),

      body: emailAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 12),
              const Text(
                "Failed to load email",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  e.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),

        data: (email) {
          final computedBodyHash = HashUtils.sha256FromString(email.body);
          final isBodyValid = computedBodyHash == email.bodyHash;

          final computedImageHash = HashUtils.sha256FromBytes(email.imageBytes);
          final isImageValid = computedImageHash == email.imageHash;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                email.subject,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Icon(Icons.star_border, size: 18),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blueGrey.shade700,
                            child: Text(
                              email.senderName.isNotEmpty
                                  ? email.senderName[0].toUpperCase()
                                  : "?",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(fontSize: 14),
                                    children: [
                                      TextSpan(
                                        text: email.senderName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " <${email.senderEmail}>",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Text(
                                  "to me",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            "12:30 PM",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      VerificationBadge(verified: isBodyValid),

                      const SizedBox(height: 16),

                      // Email Body
                      Text(
                        email.body,
                        style: const TextStyle(fontSize: 13, height: 1.5),
                      ),

                      const SizedBox(height: 32),

                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "ATTACHMENT",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          VerificationBadge(verified: isImageValid),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Container(
                        width: 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                              child: Image.memory(
                                Uint8List.fromList(email.imageBytes),
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      height: 140,
                                      color: Colors.grey.shade200,
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                      ),
                                    ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "attachment.jpg",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
