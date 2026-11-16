import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/halaman_input_deteksi.dart';
import 'pages/halaman_tentang.dart';
import 'pages/kerangka_navigasi.dart';
import 'pages/app_routes.dart';
import 'pages/tema_aplikasi.dart';
import 'state/deteksi_cubit.dart';
import 'state/tema_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AgriVisionApp());
}

class AgriVisionApp extends StatelessWidget {
  const AgriVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeteksiCubit>(
          create: (_) => DeteksiCubit(),
        ),
        BlocProvider<TemaCubit>(
          create: (_) => TemaCubit(),
        ),
      ],
      child: BlocBuilder<TemaCubit, ThemeMode>(
        builder: (context, modeTema) {
          return MaterialApp(
            title: 'AgriVision CNN',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: modeTema,
            initialRoute: AppRoutes.beranda,
            routes: {
              AppRoutes.beranda: (context) => const KerangkaNavigasi(),
              AppRoutes.tentang: (context) => const HalamanTentang(),
              AppRoutes.inputDeteksi: (context) => const HalamanInputDeteksi(),
            },
          );
        },
      ),
    );
  }
}
