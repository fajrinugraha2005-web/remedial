import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/hasil_deteksi.dart';
import '../state/deteksi_cubit.dart';

class HalamanInputDeteksi extends StatefulWidget {
  const HalamanInputDeteksi({super.key});

  @override
  State<HalamanInputDeteksi> createState() => _HalamanInputDeteksiState();
}

class _HalamanInputDeteksiState extends State<HalamanInputDeteksi> {
  final _formKey = GlobalKey<FormState>();

  String _petakTerpilih = 'Petak 1';
  String _kelasTerpilih = daftarPilihanKelas.first;

  final TextEditingController _skorController = TextEditingController();
  final TextEditingController _petugasController = TextEditingController();

  bool _dataSudahBenar = false;

  @override
  void dispose() {
    _skorController.dispose();
    _petugasController.dispose();
    super.dispose();
  }

  void _simpanData() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final double skor = double.parse(_skorController.text.trim());
    final String petugas = _petugasController.text.trim();

    final dataBaru = HasilDeteksi(
      petak: _petakTerpilih,
      kelas: _kelasTerpilih,
      skor: skor,
      namaPetugas: petugas,
      waktu: DateTime.now(),
    );

    // Tampilkan AlertDialog konfirmasi sebelum data disimpan
    showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Konfirmasi Penyimpanan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Apakah data deteksi berikut sudah sesuai?'),
            const SizedBox(height: 12),
            Text('• Lokasi: $_petakTerpilih'),
            Text('• Kelas: $_kelasTerpilih'),
            Text('• Skor: ${skor.toStringAsFixed(0)}%'),
            Text('• Status: ${dataBaru.status}'),
            Text('• Petugas: $petugas'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogCtx, true),
            child: const Text('Simpan'),
          ),
        ],
      ),
    ).then((konfirmasi) {
      if (konfirmasi == true && mounted) {
        context.read<DeteksiCubit>().tambahData(dataBaru);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data tersimpan'),
            backgroundColor: Color(0xFF2E7D32),
          ),
        );
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Deteksi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian Pilihan Petak
              Text(
                'Petak',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: skema.onSurface,
                ),
              ),
              const SizedBox(height: 6),
              Card(
                elevation: 0,
                color: isDark ? skema.surfaceContainerHigh : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(
                    color: isDark ? Colors.white12 : Colors.grey.shade300,
                  ),
                ),
                child: Column(
                  children: daftarPilihanPetak.map((petak) {
                    return RadioListTile<String>(
                      title: Text(petak),
                      value: petak,
                      // ignore: deprecated_member_use
                      groupValue: _petakTerpilih,
                      // ignore: deprecated_member_use
                      onChanged: (val) {
                        if (val != null) setState(() => _petakTerpilih = val);
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 18),

              // Bagian DropdownButtonFormField Kelas Prediksi
              Text(
                'Kelas Prediksi',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: skema.onSurface,
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _kelasTerpilih,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDark ? skema.surfaceContainerHigh : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: isDark ? Colors.white12 : Colors.grey.shade300,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.category_outlined),
                ),
                items: daftarPilihanKelas.map((kelas) {
                  return DropdownMenuItem(
                    value: kelas,
                    child: Text(kelas),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _kelasTerpilih = val);
                },
              ),
              const SizedBox(height: 18),

              // Bagian TextField Skor Deteksi (%)
              Text(
                'Skor Deteksi (%)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: skema.onSurface,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _skorController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Contoh: 85',
                  filled: true,
                  fillColor: isDark ? skema.surfaceContainerHigh : Colors.white,
                  suffixText: '%',
                  prefixIcon: const Icon(Icons.percent_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: isDark ? Colors.white12 : Colors.grey.shade300,
                    ),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Skor deteksi wajib diisi.';
                  }
                  final n = double.tryParse(val.trim());
                  if (n == null || n < 0 || n > 100) {
                    return 'Skor harus berupa angka antara 0–100.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Bagian TextField Nama Petugas
              Text(
                'Nama Petugas',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: skema.onSurface,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _petugasController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: 'Masukkan nama petugas pemeriksa',
                  filled: true,
                  fillColor: isDark ? skema.surfaceContainerHigh : Colors.white,
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: isDark ? Colors.white12 : Colors.grey.shade300,
                    ),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Nama petugas tidak boleh kosong.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // CheckboxListTile "Data sudah benar"
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Data sudah benar'),
                value: _dataSudahBenar,
                onChanged: (val) {
                  setState(() => _dataSudahBenar = val ?? false);
                },
              ),
              const SizedBox(height: 16),

              // Tombol Simpan
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: _dataSudahBenar ? _simpanData : null,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

