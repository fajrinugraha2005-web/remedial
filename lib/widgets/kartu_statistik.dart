import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String label;
  final int jumlah;
  final Color warna;
  final IconData ikon;

  const StatCard({
    super.key,
    required this.label,
    required this.jumlah,
    required this.warna,
    required this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? skema.surfaceContainerHigh : skema.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: warna.withValues(alpha: 0.25),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: warna.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: warna.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(ikon, color: warna, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            '$jumlah',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: warna,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: skema.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

