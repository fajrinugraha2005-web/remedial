import '../models/hasil_deteksi.dart';

class DeteksiState {
  final List<HasilDeteksi> semuaData;
  final String filterPetak;

  const DeteksiState({
    this.semuaData = const [],
    this.filterPetak = 'Semua',
  });

  List<HasilDeteksi> get dataTerfilter {
    List<HasilDeteksi> daftar = semuaData;
    if (filterPetak != 'Semua') {
      daftar = daftar.where((item) => item.petak == filterPetak).toList();
    }
    // Urutkan dari yang paling baru
    final terurut = List<HasilDeteksi>.from(daftar);
    terurut.sort((a, b) => b.waktu.compareTo(a.waktu));
    return terurut;
  }

  int get totalData => semuaData.length;

  int get totalSehat =>
      semuaData.where((item) => item.status == 'Sehat').length;

  int get totalTidakPasti =>
      semuaData.where((item) => item.status == 'Tidak Pasti').length;

  int get totalPerluTindakan =>
      semuaData.where((item) => item.status == 'Perlu Tindakan').length;

  Map<String, int> get jumlahPerKelas {
    final Map<String, int> map = {
      for (final kelas in daftarPilihanKelas) kelas: 0,
    };
    for (final item in semuaData) {
      if (map.containsKey(item.kelas)) {
        map[item.kelas] = map[item.kelas]! + 1;
      }
    }
    return map;
  }

  DeteksiState copyWith({
    List<HasilDeteksi>? semuaData,
    String? filterPetak,
  }) {
    return DeteksiState(
      semuaData: semuaData ?? this.semuaData,
      filterPetak: filterPetak ?? this.filterPetak,
    );
  }
}

