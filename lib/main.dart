import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/configs/theme/app_theme.dart';
import 'package:music_app/firebase_options.dart';
import 'package:music_app/presentation/chooseTheme/bloc/theme_cubit.dart';
import 'package:music_app/presentation/dashboard/bloc/navigation_cubit.dart';
import 'package:music_app/presentation/explore/bloc/explore_bloc.dart';
import 'package:music_app/presentation/favourites/bloc/favourites_bloc.dart';
import 'package:music_app/presentation/home/bloc/all_songs_bloc.dart';
import 'package:music_app/presentation/player/bloc/player_position/player_position_bloc.dart';
import 'package:music_app/presentation/playlistDetails/playlistDetailsBloc/playlist_details_bloc.dart';
import 'package:music_app/presentation/profile/bloc/profile_bloc.dart';
import 'package:music_app/presentation/register/bloc/loading/loading_bloc.dart';
import 'package:music_app/presentation/splash/pages/splashScreen.dart';
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
        BlocProvider(create: (_) => sl<PlayerPositionBloc>()),
        BlocProvider(create: (_) => sl<FavouritesBloc>()),
        BlocProvider(create: (_) => sl<ExploreBloc>()),
        BlocProvider(create: (_) => sl<ProfileBloc>()),
        BlocProvider(create: (_) => sl<PlaylistDetailsBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder:
            (context, mode) => MaterialApp(
              title: 'Melodify',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: mode,
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            ),
      ),
    );
  }
}
