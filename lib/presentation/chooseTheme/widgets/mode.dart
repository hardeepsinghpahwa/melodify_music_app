import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';
import 'package:music_app/presentation/chooseTheme/bloc/theme_cubit.dart';

class Mode extends StatelessWidget {

  final bool light;
  final bool selected;

  const Mode({required this.light,required this.selected,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            context.read<ThemeCubit>().updateTheme(light?ThemeMode.light:ThemeMode.dark);
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: selected?AppColors.primary:Colors.grey.withValues(alpha: 0.5),
                shape: BoxShape.circle,

            ),
            child:  Icon(
              light?Icons.light_mode:Icons.dark_mode_outlined,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 10,),
        Text(light? "Light Mode": "Dark Mode",
          style: TextStyle(
              color: Colors.white
          ),)
      ],
    );
  }
}
