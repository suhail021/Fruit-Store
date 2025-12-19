// lib/features/home/presentation/views/widgets/order_status_badge.dart
import 'package:flutter/material.dart';

class OrderStatusBadge extends StatelessWidget {
  final String status;
  final String label;

  const OrderStatusBadge({
    super.key,
    required this.status,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getStatusColors(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colors['background'],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors['border']!, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: colors['dot'],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: colors['text'],
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, Color> _getStatusColors(String status) {
    switch (status) {
      case 'payment':
        return {
          'background': const Color(0xFFFFF4E5),
          'border': const Color(0xFFFFB020),
          'dot': const Color(0xFFFFB020),
          'text': const Color(0xFFB37B00),
        };
      case 'paymented':
        return {
          'background': const Color(0xFFFFF3E0),
          'border': const Color(0xFFFFA726),
          'dot': const Color(0xFFFFA726),
          'text': const Color(0xFFE65100),
        };
      case 'confirmed':
        return {
          'background': const Color(0xFFE3F2FD),
          'border': const Color(0xFF2196F3),
          'dot': const Color(0xFF2196F3),
          'text': const Color(0xFF0D47A1),
        };
      case 'ordered':
        return {
          'background': const Color(0xFFE8F5E9),
          'border': const Color(0xFF66BB6A),
          'dot': const Color(0xFF66BB6A),
          'text': const Color(0xFF1B5E20),
        };
      case 'done':
        return {
          'background': const Color(0xFFC8E6C9),
          'border': const Color(0xFF4CAF50),
          'dot': const Color(0xFF4CAF50),
          'text': const Color(0xFF1B5E20),
        };
      default:
        return {
          'background': const Color(0xFFF5F5F5),
          'border': const Color(0xFF9E9E9E),
          'dot': const Color(0xFF9E9E9E),
          'text': const Color(0xFF424242),
        };
    }
  }
}
