import 'package:flutter/material.dart';
import '../models/hasil_deteksi.dart';

class DeteksiCard extends StatelessWidget {
  final HasilDeteksi data;
  final VoidCallback onHapus;

  const DeteksiCard({
    super.key,
    required this.data,
    required this.onHapus,
  });

  String _formatWaktu(DateTime dt) {
    String dua(int n) => n.toString().padLeft(2, '0');
    return '${dua(dt.day)}/${dua(dt.month)}/${dt.year} ${dua(dt.hour)}:${dua(dt.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: data.warnaStatus.withValues(alpha: 0.3),
          width: 1.2,
        ),
      ),
      color: isDark ? skema.surfaceContainerLow : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris atas: Petak & Kelas + Tombol Hapus
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: data.warnaStatus.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(data.ikonStatus, color: data.warnaStatus, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data.petak} • ${data.kelas}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Badge Status
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: data.warnaStatus.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          data.status,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: data.warnaStatus,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline,
                      color: skema.error.withValues(alpha: 0.8), size: 22),
                  tooltip: 'Hapus data',
                  onPressed: onHapus,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Skor Deteksi + LinearProgressIndicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Skor Deteksi:',
                  style: TextStyle(fontSize: 13, color: skema.onSurfaceVariant),
                ),
                Text(
                  '${data.skor.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: data.warnaStatus,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: (data.skor / 100.0).clamp(0.0, 1.0),
                minHeight: 8,
                backgroundColor: isDark
                    ? Colors.white10
                    : Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(data.warnaStatus),
              ),
            ),
            const SizedBox(height: 12),

            // Rekomendasi
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDark
                    ? skema.surfaceContainerHigh
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isDark ? Colors.white12 : Colors.grey.shade200,
                ),
              ),
              child: Text(
                data.rekomendasi,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.35,
                  color: skema.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Waktu dan Petugas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.person_outline,
                        size: 14, color: skema.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text(
                      data.namaPetugas,
                      style: TextStyle(
                        fontSize: 11,
                        color: skema.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time,
                        size: 14, color: skema.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text(
                      _formatWaktu(data.waktu),
                      style: TextStyle(
                        fontSize: 11,
                        color: skema.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

