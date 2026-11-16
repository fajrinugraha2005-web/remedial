import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/hasil_deteksi.dart';
import '../models/simulasi_data.dart';
import 'deteksi_state.dart';

class DeteksiCubit extends Cubit<DeteksiState> {
  DeteksiCubit() : super(const DeteksiState());

  void tambahData(HasilDeteksi data) {
    emit(state.copyWith(semuaData: [data, ...state.semuaData]));
  }

  void hapusData(String id) {
    final listBaru =
        state.semuaData.where((item) => item.id != id).toList();
    emit(state.copyWith(semuaData: listBaru));
  }

  void setFilterPetak(String petak) {
    emit(state.copyWith(filterPetak: petak));
  }

  void muatDataSimulasi() {
    final simulasi = buatDataSimulasi();
    emit(state.copyWith(semuaData: [...simulasi, ...state.semuaData]));
  }

  void hapusSemuaData() {
    emit(state.copyWith(semuaData: []));
  }
}

