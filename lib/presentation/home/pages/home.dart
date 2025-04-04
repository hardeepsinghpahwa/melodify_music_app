import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/core/configs/assets/app_images.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/presentation/home/bloc/all_songs_bloc.dart';

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
                    Icon(Icons.search_sharp, size: 40),
                    Spacer(),
                    SvgPicture.asset(AppVectors.logo, width: 120),
                    Spacer(),
                    Icon(Icons.menu_sharp, size: 40),
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
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.green,
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
                                    "New Album",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Happier Than Ever",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    "Billie Eilish",
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
                      padding: EdgeInsets.only(right: 30),
                      child: Image.asset(AppImages.billie),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Top 10",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 220,
                  child: ListView(
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      item("1"),
                      item("2"),
                      item("3"),
                      item("4"),
                      item("5"),
                      item("6"),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      "Playlist",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "See More",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 10),
                BlocBuilder<AllSongsBloc, AllSongsState>(
                  builder: (context, state) {
                    if (state is AllSongsLoading) {
                      return CircularProgressIndicator();
                    }

                    if (state is AllSongsLoadingFailed) {
                      return Text("Loading Failed");
                    }

                    if (state is AllSongsLoaded) {
                      var songs = state.songs;
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: songs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return playlistItem(songs[index]);
                        },
                      );
                    }

                    return SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget item(String posi) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10),
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Image.asset(AppImages.preview, fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 0,
                right: 20,
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
                      size: 35,
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 20,
                top: 0,
                child: Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      posi,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 50,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = AppColors.green,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      posi,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            maxLines: 1,
            "Bad Guy",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            maxLines: 1,
            "Billie Eilish",
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }

  Widget playlistItem(SongEntity song) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                maxLines: 1,
                song.title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(maxLines: 1, song.artist, style: TextStyle(fontSize: 10)),
            ],
          ),
          Spacer(),
          Text(song.duration.toString()),
          SizedBox(width: 40),
          Icon(Icons.favorite, color: AppColors.grey, size: 20),
          SizedBox(width: 30),
        ],
      ),
    );
  }
}
