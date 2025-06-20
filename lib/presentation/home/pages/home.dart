import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/helpers/is_dark_mode.dart';
import 'package:music_app/common/widgets/inputField.dart';
import 'package:music_app/core/configs/assets/app_images.dart';
import 'package:music_app/core/configs/theme/app_colors.dart';
import 'package:music_app/domain/entities/song/playlist.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/presentation/home/bloc/all_songs_bloc.dart';
import 'package:music_app/presentation/player/player.dart';
import 'package:music_app/presentation/playlistDetails/pages/playlistDetails.dart';

import '../../../common/utils.dart';
import '../../../common/widgets/text_button.dart';
import '../../../services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController playlistNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      sl<AllSongsBloc>().add(AllSongsLoadingEvent());
      sl<AllSongsBloc>().add(Top10SongsLoadingEvent());
      sl<AllSongsBloc>().add(PublicPlaylistsEvent());
      sl<AllSongsBloc>().add(MyPlaylistsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AllSongsBloc, AllSongsState>(
          listener: (context, state) async {
            if (state.msg.isNotEmpty) {
              Utils.showInfoSnackbar(state.msg, context);
            }

            // if(state.backPress){
            //   if(context.mounted){
            //     Navigator.pop(context);
            //   }
            // }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(left: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        //Icon(Icons.search_sharp, size: 40),
                        Spacer(),
                        Image.asset(AppImages.logo, width: 80),
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
                          margin: EdgeInsets.only(right: 10),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                      "Trending Playlists",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Builder(
                      builder: (context) {
                        if (state.loading == true) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          );
                        }

                        if ((state.publicPlaylists ?? []).isNotEmpty) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.publicPlaylists!.length,
                            // This next line does the trick.
                            itemBuilder: (BuildContext context, int index) {
                              return playlistItem(
                                state.publicPlaylists ?? [],
                                index,
                              );
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 3,
                                ),
                          );
                        }
                        return SizedBox();
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Top 10 Songs",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Builder(
                      builder: (context) {
                        if (state.loading == true) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          );
                        }

                        if ((state.topSongs ?? []).isNotEmpty) {
                          return SizedBox(
                            height: 180,
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
                    Text(
                      "Popular and Trending",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Builder(
                      builder: (context) {
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
                              return popularItem(songs, index);
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
            );
          },
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
                width: 140,
                height: 180,
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

  Widget popularItem(List<SongEntity> songs, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 15),
      child: Material(
        color: context.isDarkMode ? Colors.transparent : Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            // await sl<SharedPreferences>().setString("songs", jsonEncode(songs));
            // await sl<SharedPreferences>().setInt("index", index);

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (ctx) => AudioPlayerScreen(songs: songs, index: index),
            //   ),
            // );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                songs[index].image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
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
                      color: context.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    maxLines: 1,
                    songs[index].artist,
                    style: TextStyle(
                      fontSize: 10,
                      color: context.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                songs[index].duration.toString(),
                style: TextStyle(
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(width: 15),
              // Icon(
              //   Icons.favorite_border,
              //   color: context.isDarkMode?Colors.white:Colors.black,
              //   size: 20,
              // ),
              // SizedBox(width: 10),
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
              GestureDetector(
                onTap: () {
                  playlistBottomSheet(songs[index].id);
                },
                child: Icon(
                  Icons.add_circle_outline, // Icon
                  color: Colors.black54,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  playlistBottomSheet(String id) {
    showModalBottomSheet(
      showDragHandle: true,
      elevation: 10,
      context: context,
      backgroundColor: Colors.white,
      builder: (ctx) {
        return SingleChildScrollView(
          child: BlocBuilder<AllSongsBloc, AllSongsState>(
            builder: (context, state) {
              return Container(
                clipBehavior: Clip.antiAlias,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      "Add to Playlist",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Builder(
                      builder: (context) {
                        if (state.loading == true) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          );
                        }

                        if ((state.myPlaylists ?? []).isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.myPlaylists!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return addToPlaylistItem(
                                state.myPlaylists!,
                                index,
                                songId: id,
                              );
                            },
                          );
                        }
                        return SizedBox();
                      },
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          newPlaylistDialog();
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, color: AppColors.primary),
                              SizedBox(width: 5),
                              Text(
                                "Add New",
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  newPlaylistDialog() {
    playlistNameController.clear();
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            child: BlocBuilder<AllSongsBloc, AllSongsState>(
              builder: (context, state) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InputField(
                        hint: "New Playlist Name",
                        input: TextInputType.name,
                        validator: null,
                        autoFocus: true,
                        controller: playlistNameController,
                      ),
                      SizedBox(height: 10),
                      state.dialogLoading
                          ? CircularProgressIndicator(color: AppColors.primary)
                          : BasicTextButton(
                            onPressed: () {
                              if (playlistNameController.text.isEmpty) {
                                Utils.showErrorSnackbar(
                                  "Please enter playlist name",
                                  context,
                                );
                              } else {
                                sl<AllSongsBloc>().add(
                                  CreateNewPlaylistEvent(
                                    playlistNameController.text,
                                  ),
                                );
                              }
                            },
                            title: 'Create',
                          ),
                    ],
                  ),
                );
              },
            ),
          ),
    );
  }

  Widget playlistItem(List<Playlist> playlists, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      child: Material(
        color: context.isDarkMode ? Colors.grey : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (ctx) => PlaylistDetails(playlistDetails: playlists[index]),
              ),
            );
          },
          child: Row(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  playlists[index].image,
                  errorBuilder: (ctx, obj, stk) {
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(color: AppColors.primary),
                      child: Icon(
                        Icons.music_note_outlined,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 10),
              Text(playlists[index].name),
              Spacer(),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget addToPlaylistItem(
    List<Playlist> playlists,
    int index, {
    String songId = "",
  }) {
    bool exists = (playlists[index].songs ?? []).any(
      (val) => val.songId == songId,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      child: Material(
        color: context.isDarkMode ? Colors.grey : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                  playlists[index].image,
                  width: 50,
                  height: 50,
                  errorBuilder: (ctx, obj, stk) {
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(color: AppColors.primary),
                      child: Icon(
                        Icons.queue_music_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(playlists[index].name),
                  Visibility(
                    visible: exists,
                    child: Row(
                      children: [
                        Text(
                          "Song Added",
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.check_circle, color: Colors.green, size: 15),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              BlocBuilder<AllSongsBloc, AllSongsState>(
                builder: (context, state) {
                  return (state.playlistLoader ?? []).contains(
                        playlists[index].id,
                      )
                      ? SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 1,
                        ),
                      )
                      : GestureDetector(
                        onTap: () {
                          if (!exists) {
                            sl<AllSongsBloc>().add(
                              AddSongToPlaylistEvent(
                                playlists[index].id,
                                songId,
                                true,
                              ),
                            );
                          } else {
                            sl<AllSongsBloc>().add(
                              AddSongToPlaylistEvent(
                                playlists[index].id,
                                songId,
                                false,
                              ),
                            );
                          }
                        },
                        child: Icon(
                          exists
                              ? Icons.remove_circle_outline
                              : Icons.add_circle,
                          color: exists ? Colors.redAccent : Colors.green,
                          size: 20,
                        ),
                      );
                },
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
