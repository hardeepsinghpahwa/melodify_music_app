import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/common/helpers/is_dark_mode.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';
import 'package:music_app/presentation/dashboard/bloc/navigation_cubit.dart';
import 'package:music_app/presentation/explore/pages/explore.dart';
import 'package:music_app/presentation/favourites/pages/favourites.dart';
import 'package:music_app/presentation/home/pages/home.dart';
import 'package:music_app/presentation/player/bloc/player_position/player_position_bloc.dart';
import 'package:music_app/presentation/profile/pages/profile_screen.dart';

import '../../../services.dart';
import '../../player/player.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final PageController pageController = PageController();
  final player = sl<AudioPlayer>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightGrey,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  HomeScreen(),
                  ExploreScreen(),
                  FavouritesScreen(),
                  ProfileScreen(),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  BlocBuilder<PlayerPositionBloc, PlayerCurrentState>(
                    builder: (context, state) {
                      if (state.currentSong != null) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (ctx) => AudioPlayerScreen(
                                      songs: state.songs ?? [],
                                      index: state.currentIndex,
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color:
                                  context.isDarkMode
                                      ? Colors.grey.shade500
                                      : AppColors.lightGrey,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      state.currentSong?.image ?? "",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.currentSong?.title ?? "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color:
                                                context.isDarkMode
                                                    ? Colors.white
                                                    : Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          state.currentSong?.artist ?? "",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     int nextIndex = 0;
                                    //     if (currentIndex != 0) {
                                    //       nextIndex = currentIndex - 1;
                                    //     } else {
                                    //       nextIndex = widget.songs.length - 1;
                                    //     }
                                    //     currentIndex = nextIndex;
                                    //     changeSong(widget.songs[nextIndex]);
                                    //   },
                                    //   child: Icon(
                                    //     Icons.arrow_circle_left_outlined,
                                    //     size: 30,
                                    //   ),
                                    // ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () async {
                                        player.resume();
                                        if (player.state ==
                                            PlayerState.playing) {
                                          sl<PlayerPositionBloc>().add(
                                            PlayerPlayChangeEvent(false),
                                          );
                                          player.pause();
                                        } else {
                                          sl<PlayerPositionBloc>().add(
                                            PlayerPlayChangeEvent(true),
                                          );
                                        }
                                      },
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          !state.isPlaying
                                              ? Icons.play_arrow
                                              : Icons.pause,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     int nextIndex = 0;
                                    //     if (currentIndex != widget.songs.length - 1) {
                                    //       nextIndex = currentIndex + 1;
                                    //     }
                                    //     currentIndex = nextIndex;
                                    //     changeSong(widget.songs[nextIndex]);
                                    //   },
                                    //   child: Icon(
                                    //     Icons.arrow_circle_right_outlined,
                                    //     size: 30,
                                    //   ),
                                    // ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                                SliderTheme(
                                  data: SliderThemeData(
                                    thumbColor: AppColors.primary,
                                    thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 0,
                                    ),
                                  ),
                                  child: Slider(
                                    allowedInteraction:
                                        SliderInteraction.tapAndSlide,
                                    padding: EdgeInsets.zero,
                                    activeColor: AppColors.primary,
                                    value: state.position.toDouble(),
                                    min: 0.0,
                                    max: state.duration.toDouble() + 1,
                                    onChanged: (value) {
                                      if (player.source == null) {
                                        player.setSource(
                                          UrlSource(
                                            state.currentSong?.link ?? "",
                                          ),
                                        );
                                      }
                                      player.seek(
                                        Duration(seconds: value.toInt()),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  Container(
                    height: 50,
                    color:
                        context.isDarkMode
                            ? AppColors.darkBackground
                            : Colors.white,
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
                ],
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
              SizedBox(height: 10),
              SvgPicture.asset(
                icon,
                width: 10,
                height: 25,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  valueState == state ? AppColors.primary : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              Spacer(),
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
                    height: 2,
                  )
                  : SizedBox(),
              SizedBox(height: 5),
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
