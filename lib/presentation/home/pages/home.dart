import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/core/configs/assets/app_images.dart';
import 'package:music_app/core/configs/assets/app_vectors.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                SizedBox(
                  height: 220,
                  child: ListView(
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      item(),
                      item(),
                      item(),
                      item(),
                      item(),
                      item(),
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
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // This next line does the trick.
                  children: <Widget>[
                    playlistItem(),
                    playlistItem(),
                    playlistItem(),
                    playlistItem(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget item() {
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

  Widget playlistItem() {
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
            children: [
              Text(
                maxLines: 1,
                "Bad Guy",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                maxLines: 1,
                "Billie Eilish",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
          Spacer(),
          Text("5:33"),
          SizedBox(width: 40),
          Icon(Icons.favorite, color: AppColors.grey, size: 20),
          SizedBox(width: 30),
        ],
      ),
    );
  }
}
