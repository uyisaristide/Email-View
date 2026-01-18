import 'package:flutter/material.dart';

class VerificationBadge extends StatelessWidget {
  final bool verified;

  const VerificationBadge({required this.verified, super.key});

  @override
  Widget build(BuildContext context) {
    final color = verified ? const Color(0xFF006B5E) : const Color(0xFFB3261E);
    final bgColor = verified ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE);
    final icon = verified ? Icons.verified_user_rounded : Icons.gpp_maybe_rounded;
    final label = verified ? "Verified" : "Failed";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}