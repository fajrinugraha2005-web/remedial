import 'package:flutter/material.dart';
import '../models/hasil_deteksi.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang AgriVision'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          // Kartu Tujuan Aplikasi
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isDark ? skema.surfaceContainerHigh : skema.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: skema.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.track_changes_rounded, color: skema.primary, size: 24),
                    const SizedBox(width: 10),
                    Text(
                      'Tujuan Aplikasi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: skema.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Aplikasi AgriVision CNN dirancang untuk mendigitalisasi pencatatan hasil deteksi penyakit dan hama padi pada kelompok tani (Petak 1 dan Petak 2). Dengan memanfaatkan inferensi model EfficientNet-B0, aplikasi membantu petugas memantau riwayat deteksi, menganalisis statistik penyebaran penyakit, dan memperoleh rekomendasi penanganan secara cepat guna mencegah gagal panen.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.45,
                    color: skema.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Judul Daftar 5 Kelas
          Text(
            'Daftar 5 Kelas Deteksi',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),

          // Daftar 5 Kelas Menggunakan ListView builder / children
          ...daftarPilihanKelas.map((kelas) {
            final isSehat = kelas == 'Normal / Sehat';
            final warna = isSehat ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
            final rekomendasi = rekomendasiPerKelas[kelas] ?? '-';

            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  color: isDark ? Colors.white12 : Colors.grey.shade200,
                ),
              ),
              color: isDark ? skema.surfaceContainerLow : Colors.white,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: warna.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isSehat ? Icons.eco_rounded : Icons.coronavirus_rounded,
                    color: warna,
                    size: 22,
                  ),
                ),
                title: Text(
                  kelas,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    rekomendasi,
                    style: TextStyle(fontSize: 12, color: skema.onSurfaceVariant),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

