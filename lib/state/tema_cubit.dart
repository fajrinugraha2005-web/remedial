import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemaCubit extends Cubit<ThemeMode> {
  TemaCubit() : super(ThemeMode.light);

  void toggleTema() {
    emit(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }

  void setTemaGelap(bool isDark) {
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}

