import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';
import 'package:music_app/presentation/dashboard/bloc/navigation_cubit.dart';
import 'package:music_app/presentation/explore/pages/explore.dart';
import 'package:music_app/presentation/favourites/pages/favourites.dart';
import 'package:music_app/presentation/home/pages/home.dart';

import '../../../services.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [HomeScreen(), ExploreScreen(), FavouritesScreen()],
              ),
            ),
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
                    bottomItem(AppVectors.home, NavigationHome()),
                    bottomItem(AppVectors.explore, NavigationExplore()),
                    bottomItem(AppVectors.fav, NavigationFav()),
                    bottomItem(AppVectors.profile, NavigationProfile()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomItem(String icon, NavigationState valueState) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            sl<NavigationCubit>().setTab(valueState);
            setScreen(valueState);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              state == valueState
                  ? Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    width: 30,
                    height: 4,
                  )
                  : SizedBox(),
              SizedBox(height: 10),
              SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  valueState == state ? AppColors.primary : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  setScreen(NavigationState state) {
    if (state is NavigationHome) {
      pageController.animateToPage(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else if (state is NavigationProfile) {
      pageController.animateToPage(
        3,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else if (state is NavigationFav) {
      pageController.animateToPage(
        2,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else if (state is NavigationExplore) {
      pageController.animateToPage(
        1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }
}
