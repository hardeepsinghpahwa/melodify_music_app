import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void updateTheme(ThemeMode mode) {
    sl<SharedPreferences>().setBool(
      "isDarkTheme",
      mode == ThemeMode.dark ? true : false,
    );

    emit(mode);
  }
}
