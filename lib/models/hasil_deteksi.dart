import 'package:flutter/material.dart';

const List<String> daftarPilihanKelas = [
  'Hawar daun bakteri',
  'Penyakit blas (jamur)',
  'Bercak coklat',
  'Normal / Sehat',
  'Penyakit tungro (virus)',
];

const List<String> daftarPilihanPetak = [
  'Petak 1',
  'Petak 2',
];

const Map<String, String> rekomendasiPerKelas = {
  'Hawar daun bakteri':
      'Kurangi pupuk urea, buang air berlebih, bersihkan jerami yang sakit.',
  'Penyakit blas (jamur)':
      'Jaga sawah tetap tergenang, semprot obat jamur saat padi keluar malai.',
  'Bercak coklat': 'Tambah pupuk kalium, jaga sawah tetap tergenang.',
  'Normal / Sehat': 'Tanaman sehat. Lanjutkan pemantauan rutin.',
  'Penyakit tungro (virus)':
      'Cabut rumpun yang sakit, musim depan pakai varietas tahan.',
};

class HasilDeteksi {
  final String id;
  final String petak;
  final String kelas;
  final double skor;
  final String namaPetugas;
  final DateTime waktu;

  HasilDeteksi({
    String? id,
    required this.petak,
    required this.kelas,
    required this.skor,
    required this.namaPetugas,
    required this.waktu,
  }) : id = id ?? DateTime.now().microsecondsSinceEpoch.toString();

  /// Logika penentuan status deteksi berdasarkan Tabel A
  String get status {
    if (kelas == 'Normal / Sehat') {
      return 'Sehat';
    } else if (skor < 50) {
      return 'Tidak Pasti';
    } else {
      return 'Perlu Tindakan';
    }
  }

  /// Logika penentuan rekomendasi berdasarkan Tabel A dan Tabel B
  String get rekomendasi {
    if (kelas == 'Normal / Sehat') {
      return 'Lanjutkan pemantauan rutin.';
    } else if (skor < 50) {
      return 'Cek ulang oleh petugas.';
    } else {
      final panduan = rekomendasiPerKelas[kelas] ?? 'Lakukan isolasi tanaman.';
      return 'Segera tangani: $panduan';
    }
  }

  Color get warnaStatus {
    switch (status) {
      case 'Sehat':
        return const Color(0xFF2E7D32); // Hijau
      case 'Tidak Pasti':
        return const Color(0xFFEF6C00); // Oranye
      case 'Perlu Tindakan':
        return const Color(0xFFC62828); // Merah
      default:
        return Colors.grey;
    }
  }

  Color get latarStatus {
    switch (status) {
      case 'Sehat':
        return const Color(0xFFE8F5E9);
      case 'Tidak Pasti':
        return const Color(0xFFFFF3E0);
      case 'Perlu Tindakan':
        return const Color(0xFFFFEBEE);
      default:
        return Colors.grey.shade100;
    }
  }

  IconData get ikonStatus {
    switch (status) {
      case 'Sehat':
        return Icons.check_circle_rounded;
      case 'Tidak Pasti':
        return Icons.help_outline_rounded;
      case 'Perlu Tindakan':
        return Icons.warning_amber_rounded;
      default:
        return Icons.info_outline;
    }
  }
}

