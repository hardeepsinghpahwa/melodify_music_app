import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SafeArea(
        child: Stack(
          children: [
            PageView(),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 60,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    bottomItem(AppVectors.home),
                    bottomItem(AppVectors.explore),
                    bottomItem(AppVectors.fav),
                    bottomItem(AppVectors.profile),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomItem(String icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5))
          ),
          width: 30,
          height: 4,
        ),
        SizedBox(height: 10,),
        SvgPicture.asset(icon),
      ],
    );
  }
}
