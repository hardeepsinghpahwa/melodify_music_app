import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/presentation/dashboard/pages/dashboard.dart';
import 'package:music_app/presentation/home/pages/home.dart';
import 'package:music_app/presentation/intro/pages/intro.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services.dart';
import '../../chooseTheme/bloc/theme_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: SvgPicture.asset(AppVectors.logo)));
  }

  Future<void> redirect() async {

    bool? isDarkTheme=sl<SharedPreferences>().getBool("isDarkTheme");

    if(isDarkTheme!=null && isDarkTheme){
      context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
    }else{
      context.read<ThemeCubit>().updateTheme(ThemeMode.light);
    }

    await Future.delayed(Duration(seconds: 2));

    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IntroScreen()),
      );
    }
  }
}
