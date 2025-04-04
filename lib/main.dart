import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/configs/theme/app_theme.dart';
import 'package:music_app/firebase_options.dart';
import 'package:music_app/presentation/chooseTheme/bloc/theme_cubit.dart';
import 'package:music_app/presentation/dashboard/bloc/navigation_cubit.dart';
import 'package:music_app/presentation/dashboard/pages/dashboard.dart';
import 'package:music_app/presentation/home/bloc/all_songs_bloc.dart';
import 'package:music_app/presentation/player/bloc/player_position/player_position_bloc.dart';
import 'package:music_app/presentation/player/bloc/player_state/player_state_cubit.dart';
import 'package:music_app/presentation/register/bloc/loading/loading_bloc.dart';
import 'package:music_app/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => sl<LoadingBloc>()),
        BlocProvider(create: (_) => sl<NavigationCubit>()),
        BlocProvider(create: (_) => sl<AllSongsBloc>()),
        BlocProvider(create: (_) => sl<PlayerStateCubit>()),
        BlocProvider(create: (_) => sl<PlayerPositionBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder:
            (context, mode) => MaterialApp(
              title: 'Flutter Demo',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: mode,
              debugShowCheckedModeBanner: false,
              home: Dashboard(),
            ),
      ),
    );
  }
}
