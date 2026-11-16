import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/hasil_deteksi.dart';
import '../state/deteksi_state.dart';
import '../state/deteksi_cubit.dart';

class HalamanStatistik extends StatelessWidget {
  const HalamanStatistik({super.key});

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<DeteksiCubit, DeteksiState>(
      builder: (context, state) {
        final jumlahMap = state.jumlahPerKelas;

        // Ambil nilai tertinggi untuk batas atas sumbu Y
        int nilaiMaks = 0;
        for (final val in jumlahMap.values) {
          if (val > nilaiMaks) nilaiMaks = val;
        }
        final double maxY = (nilaiMaks < 5 ? 5 : (nilaiMaks + 1)).toDouble();

        // 5 kelas singkatan untuk sumbu X
        final List<String> singkatan = [
          'Hawar',
          'Blas',
          'Bercak',
          'Normal',
          'Tungro'
        ];

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            Text(
              'Jumlah Deteksi per Kelas',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              'Distribusi kemunculan penyakit dan tanaman sehat hasil inferensi CNN.',
              style: TextStyle(fontSize: 13, color: skema.onSurfaceVariant),
            ),
            const SizedBox(height: 24),

            // Card Wadah Grafik BarChart
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(
                  color: isDark ? Colors.white12 : Colors.grey.shade300,
                ),
              ),
              color: isDark ? skema.surfaceContainerHigh : Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: SizedBox(
                  height: 260,
                  child: BarChart(
                    BarChartData(
                      maxY: maxY,
                      minY: 0,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final nama = daftarPilihanKelas[group.x.toInt()];
                            return BarTooltipItem(
                              '$nama\n${rod.toY.toInt()} kasus',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            interval: maxY <= 5 ? 1 : 2,
                            getTitlesWidget: (value, meta) {
                              if (value % 1 != 0) return const SizedBox();
                              return Text(
                                '${value.toInt()}',
                                style: TextStyle(
                                  color: skema.onSurfaceVariant,
                                  fontSize: 11,
                                ),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index < 0 || index >= singkatan.length) {
                                return const SizedBox();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  singkatan[index],
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: skema.onSurface,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 1,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: isDark ? Colors.white10 : Colors.grey.shade200,
                          strokeWidth: 1,
                          dashArray: [4, 4],
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          bottom: BorderSide(
                            color: isDark ? Colors.white24 : Colors.grey.shade400,
                          ),
                          left: BorderSide(
                            color: isDark ? Colors.white24 : Colors.grey.shade400,
                          ),
                        ),
                      ),
                      barGroups: List.generate(5, (index) {
                        final namaKelas = daftarPilihanKelas[index];
                        final jumlah = (jumlahMap[namaKelas] ?? 0).toDouble();
                        final isSehat = namaKelas == 'Normal / Sehat';

                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: jumlah,
                              color: isSehat
                                  ? const Color(0xFF2E7D32)
                                  : (jumlah > 0
                                      ? skema.primary
                                      : Colors.grey.shade400),
                              width: 18,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Rincian Data per Kelas
            Text(
              'Rincian per Kelas',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),

            ...daftarPilihanKelas.map((kelas) {
              final count = jumlahMap[kelas] ?? 0;
              final isSehat = kelas == 'Normal / Sehat';

              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isDark ? Colors.white10 : Colors.grey.shade200,
                  ),
                ),
                color: isDark ? skema.surfaceContainerLow : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isSehat
                              ? const Color(0xFF2E7D32)
                              : skema.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          kelas,
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '$count kasus',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: count > 0 ? skema.primary : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

