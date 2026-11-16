import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/deteksi_state.dart';
import '../state/deteksi_cubit.dart';
import '../widgets/kartu_deteksi.dart';
import '../widgets/kartu_statistik.dart';
import 'app_routes.dart';

class HalamanDeteksi extends StatelessWidget {
  const HalamanDeteksi({super.key});

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.inputDeteksi);
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Deteksi Baru'),
      ),
      body: BlocBuilder<DeteksiCubit, DeteksiState>(
        builder: (context, state) {
          final daftar = state.dataTerfilter;

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // Judul & Filter Petak
              Text(
                'Riwayat Deteksi',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),

              // SegmentedButton untuk filter petak
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Semua', label: Text('Semua')),
                  ButtonSegment(value: 'Petak 1', label: Text('Petak 1')),
                  ButtonSegment(value: 'Petak 2', label: Text('Petak 2')),
                ],
                selected: {state.filterPetak},
                onSelectionChanged: (Set<String> newSelection) {
                  context
                      .read<DeteksiCubit>()
                      .setFilterPetak(newSelection.first);
                },
              ),
              const SizedBox(height: 16),

              // Tiga kartu statistik: Total, Sehat, Perlu Tindakan
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      label: 'Total',
                      jumlah: state.totalData,
                      warna: skema.primary,
                      ikon: Icons.analytics_outlined,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: StatCard(
                      label: 'Sehat',
                      jumlah: state.totalSehat,
                      warna: const Color(0xFF2E7D32),
                      ikon: Icons.check_circle_outline_rounded,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: StatCard(
                      label: 'Perlu Tindakan',
                      jumlah: state.totalPerluTindakan,
                      warna: const Color(0xFFC62828),
                      ikon: Icons.warning_amber_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Daftar Hasil Deteksi
              if (daftar.isEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 56,
                        color: skema.onSurfaceVariant.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Belum ada data',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: skema.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tekan "Deteksi Baru" atau muat data simulasi pada tab Pengaturan.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: skema.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...daftar.map((item) {
                  return DeteksiCard(
                    data: item,
                    onHapus: () {
                      context.read<DeteksiCubit>().hapusData(item.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Data ${item.petak} - ${item.kelas} berhasil dihapus.'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  );
                }),
            ],
          );
        },
      ),
    );
  }
}

