import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/deteksi_cubit.dart';
import '../state/tema_cubit.dart';

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  void _konfirmasiHapusSemua(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 40),
        title: const Text('Hapus Semua Data?'),
        content: const Text(
          'Tindakan ini akan menghapus seluruh rekaman data deteksi penyakit padi dari aplikasi. Data yang telah dihapus tidak dapat dipulihkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          FilledButton.tonal(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.shade100,
              foregroundColor: Colors.red.shade900,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              context.read<DeteksiCubit>().hapusSemuaData();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Semua data deteksi telah berhasil dihapus.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final temaMode = context.watch<TemaCubit>().state;
    final isDark = temaMode == ThemeMode.dark;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          'Tampilan & Tema',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          color: theme.colorScheme.surfaceContainerHighest.withAlpha(128),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: theme.colorScheme.outlineVariant),
          ),
          child: SwitchListTile(
            secondary: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: isDark ? Colors.amber : theme.colorScheme.primary,
            ),
            title: const Text(
              'Mode Gelap',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              isDark ? 'Tema gelap aktif' : 'Tema terang aktif',
            ),
            value: isDark,
            onChanged: (_) {
              context.read<TemaCubit>().toggleTema();
            },
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Manajemen Data Simulasi',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          color: theme.colorScheme.surfaceContainerHighest.withAlpha(128),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: theme.colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Icon(Icons.auto_mode_rounded, color: theme.colorScheme.primary),
                  ),
                  title: const Text(
                    'Muat Data Simulasi',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text(
                    'Menambahkan 10 data simulasi acak deteksi penyakit padi untuk pengujian.',
                  ),
                  trailing: FilledButton.icon(
                    icon: const Icon(Icons.download, size: 18),
                    label: const Text('Muat'),
                    onPressed: () {
                      context.read<DeteksiCubit>().muatDataSimulasi();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('10 data simulasi berhasil dimuat!'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),
                const Divider(height: 24),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Colors.red.shade100,
                    child: const Icon(Icons.delete_forever_rounded, color: Colors.red),
                  ),
                  title: const Text(
                    'Hapus Semua Data',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
                  ),
                  subtitle: const Text(
                    'Kosongkan seluruh riwayat dan data deteksi saat ini.',
                  ),
                  trailing: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text('Hapus'),
                    onPressed: () => _konfirmasiHapusSemua(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

