import 'package:flutter/material.dart';
import 'app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      children: [
        // Sambutan
        Text(
          'Selamat Datang di AgriVision CNN',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: skema.primary,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Sistem Cerdas Pencatatan & Pemantauan Kesehatan Tanaman Padi Berbasis AI',
          style: TextStyle(
            fontSize: 14,
            color: skema.onSurfaceVariant,
            height: 1.4,
          ),
        ),
        
        const SizedBox(height: 20),

        // Kartu Info Model (EfficientNet-B0, 5 kelas)
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
              color: skema.outlineVariant.withValues(alpha: 0.6),
            ),
          ),
          color: isDark ? skema.surfaceContainerHigh : skema.surface,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: skema.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.memory_rounded,
                        color: skema.onPrimaryContainer,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Model: EfficientNet-B0',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '5 kelas (4 penyakit + 1 Normal / Sehat)',
                            style: TextStyle(
                              fontSize: 13,
                              color: skema.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Divider(height: 1),
                const SizedBox(height: 12),
                Text(
                  'Arsitektur Convolutional Neural Network (CNN) berbobot ringan namun berakurasi tinggi untuk klasifikasi citra daun tanaman padi secara instan di lapangan.',
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.4,
                    color: skema.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Tombol menuju Halaman Tentang
        SizedBox(
          width: double.infinity,
          height: 48,
          child: FilledButton.tonalIcon(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.tentang);
            },
            icon: const Icon(Icons.info_outline_rounded),
            label: const Text(
              'Tentang Aplikasi',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

