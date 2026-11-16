import 'dart:math';
import 'hasil_deteksi.dart';

List<HasilDeteksi> buatDataSimulasi() {
  final random = Random();
  final List<HasilDeteksi> hasil = [];
  final sekarang = DateTime.now();

  final daftarPetugas = ['Budi', 'Siti', 'Asep', 'Joko', 'Dewi'];

  for (int i = 0; i < 10; i++) {
    final petak = daftarPilihanPetak[random.nextInt(daftarPilihanPetak.length)];
    final kelas = daftarPilihanKelas[random.nextInt(daftarPilihanKelas.length)];
    // Skor berupa angka bulat 30-99
    final skor = (30 + random.nextInt(70)).toDouble();
    final namaPetugas = daftarPetugas[random.nextInt(daftarPetugas.length)];
    // Mundurkan waktu beberapa menit/jam agar terurut riwayatnya
    final waktu = sekarang.subtract(Duration(minutes: (10 - i) * 15));

    hasil.add(
      HasilDeteksi(
        id: 'SIM-${sekarang.millisecondsSinceEpoch}-$i',
        petak: petak,
        kelas: kelas,
        skor: skor,
        namaPetugas: namaPetugas,
        waktu: waktu,
      ),
    );
  }

  return hasil;
}

