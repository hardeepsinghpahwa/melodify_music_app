import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/common/helpers/is_dark_mode.dart';
import 'package:music_app/core/configs/assets/app_images.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/presentation/home/bloc/all_songs_bloc.dart';
import 'package:music_app/presentation/player/player.dart';

import '../../../services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      sl<AllSongsBloc>().add(AllSongsLoadingEvent());
      sl<AllSongsBloc>().add(Top10SongsLoadingEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    //Icon(Icons.search_sharp, size: 40),
                    Spacer(),
                    SvgPicture.asset(AppVectors.logo, width: 120),
                    Spacer(),
                    //Image.asset(AppImages.dotMenu, height: 40),
                    SizedBox(width: 20),
                  ],
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(right: 20),
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primary,
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Introducing",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "48 Rhymes",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    "Karan Aujla",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Image.asset(AppImages.topSwirls),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Image.asset(AppImages.aujla, height: 160),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Top 10",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: context.isDarkMode?Colors.white:Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                BlocBuilder<AllSongsBloc, AllSongsState>(
                  builder: (context, state) {
                    if (state.loading == true) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }

                    if ((state.topSongs ?? []).isNotEmpty) {
                      return SizedBox(
                        height: 220,
                        child: ListView.builder(
                          itemCount: state.topSongs!.length,
                          // This next line does the trick.
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return item(index, state.topSongs!);
                          },
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      "Playlist",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "See More",
                      style: TextStyle(
                        fontSize: 12,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 10),
                BlocBuilder<AllSongsBloc, AllSongsState>(
                  builder: (context, state) {
                    if (state.loading == true) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }

                    if ((state.allSongs ?? []).isNotEmpty) {
                      var songs = state.allSongs!;
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: songs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return playlistItem(songs, index);
                        },
                      );
                    }

                    return SizedBox();
                  },
                ),
                SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget item(int index, List<SongEntity> song) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                width: 160,
                height: 220,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.only(left: index == 0 ? 0 : 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(song[index].image, fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (ctx) => AudioPlayerScreen(
                              songs: song,
                              index: index,
                              play: false,
                            ),
                      ),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          // Modify this till it fills the color properly
                          color: AppColors.darkGrey, // Color
                        ),
                      ),
                      Icon(
                        Icons.play_circle_rounded, // Icon
                        color: AppColors.lightGrey,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: index == 0 ? 0 : 10,
                bottom: 0,
                child: Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        height: 0.7,
                        fontSize: 80,
                        foreground:
                            Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Colors.grey,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        height: 0.7,
                        fontStyle: FontStyle.italic,
                        fontSize: 80,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            maxLines: 1,
            song[index].title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            maxLines: 1,
            song[index].artist,
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }

  Widget playlistItem(List<SongEntity> songs, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 5),
      child: Material(
        color: context.isDarkMode?Colors.transparent:Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            // await sl<SharedPreferences>().setString("songs", jsonEncode(songs));
            // await sl<SharedPreferences>().setInt("index", index);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => AudioPlayerScreen(songs: songs, index: index),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                Image.network(songs[index].image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      songs[index].title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: context.isDarkMode?Colors.white:Colors.black,
                      ),
                    ),
                    Text(
                      maxLines: 1,
                      songs[index].artist,
                      style: TextStyle(
                        fontSize: 10,
                        color: context.isDarkMode?Colors.white:Colors.black,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  songs[index].duration.toString(),
                  style: TextStyle(
                    color: context.isDarkMode?Colors.white:Colors.black,
                  ),
                ),
                SizedBox(width: 40),
                Icon(
                  Icons.favorite_border,
                  color: context.isDarkMode?Colors.white:Colors.black,
                  size: 20,
                ),
                SizedBox(width: 10),
                Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        // Modify this till it fills the color properly
                        color: AppColors.darkGrey, // Color
                      ),
                    ),
                    Icon(
                      Icons.play_circle_rounded, // Icon
                      color: AppColors.lightGrey,
                      size: 35,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
