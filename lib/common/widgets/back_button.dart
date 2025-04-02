import 'package:flutter/material.dart';
import 'package:music_app/common/helpers/is_dark_mode.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';

class RoundedBackButton extends StatelessWidget {

  const RoundedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: context.isDarkMode?AppColors.darkGrey:AppColors.lightGrey,
          shape: BoxShape.circle
        ),
        child: Icon(Icons.arrow_back_ios_new,color:context.isDarkMode
            ?Colors.white:Colors.black,size: 15,),
      ),
    );
  }
}
