import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/deteksi_state.dart';
import '../state/deteksi_cubit.dart';
import 'halaman_beranda.dart';
import 'halaman_deteksi.dart';
import 'halaman_statistik.dart';
import 'halaman_pengaturan.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksAktif = 0;

  static const List<String> _namaTab = [
    'Beranda',
    'Deteksi',
    'Statistik',
    'Pengaturan',
  ];

  static const List<Widget> _halaman = [
    HalamanBeranda(),
    HalamanDeteksi(),
    HalamanStatistik(),
    HalamanPengaturan(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AgriVision - ${_namaTab[_indeksAktif]}'),
        centerTitle: false,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _indeksAktif,
        children: _halaman,
      ),
      bottomNavigationBar: BlocBuilder<DeteksiCubit, DeteksiState>(
        builder: (context, state) {
          final perluTindakan = state.totalPerluTindakan;

          return NavigationBar(
            selectedIndex: _indeksAktif,
            onDestinationSelected: (index) {
              setState(() {
                _indeksAktif = index;
              });
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Beranda',
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: perluTindakan > 0,
                  label: Text(
                    '$perluTindakan',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.red.shade700,
                  child: const Icon(Icons.grass_outlined),
                ),
                selectedIcon: Badge(
                  isLabelVisible: perluTindakan > 0,
                  label: Text(
                    '$perluTindakan',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.red.shade700,
                  child: const Icon(Icons.grass),
                ),
                label: 'Deteksi',
              ),
              const NavigationDestination(
                icon: Icon(Icons.bar_chart_outlined),
                selectedIcon: Icon(Icons.bar_chart),
                label: 'Statistik',
              ),
              const NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Pengaturan',
              ),
            ],
          );
        },
      ),
    );
  }
}

