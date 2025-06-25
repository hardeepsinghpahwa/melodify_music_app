import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/helpers/is_dark_mode.dart';
import 'package:music_app/common/utils.dart';
import 'package:music_app/common/widgets/loader.dart';
import 'package:music_app/presentation/playlistDetails/playlistDetailsBloc/playlist_details_bloc.dart';

import '../../../common/widgets/back_button.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/song/playlist.dart';
import '../../../domain/entities/song/song.dart';
import '../../../services.dart';
import '../../player/bloc/player_position/player_position_bloc.dart';
import '../../player/player.dart';

class PlaylistDetails extends StatefulWidget {
  final Playlist playlistDetails;
  final bool favourites;

  const PlaylistDetails({
    super.key,
    required this.playlistDetails,
    this.favourites = false,
  });

  @override
  State<PlaylistDetails> createState() => _PlaylistDetailsState();
}

class _PlaylistDetailsState extends State<PlaylistDetails> {

  final player = sl<AudioPlayer>();

  @override
  void initState() {
    super.initState();
    if (widget.favourites) {
      sl<PlaylistDetailsBloc>().add(GetAllFavouritesEvent());
    } else {
      sl<PlaylistDetailsBloc>().add(
        LoadPlaylistSongs(widget.playlistDetails.id),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.statusBarColor,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: BlocConsumer<PlaylistDetailsBloc, PlaylistDetailsState>(
            listener: (context, state) {
              if (state.error != null && state.error!.isNotEmpty) {
                Utils.showErrorSnackbar(state.error ?? "", context);
                state.copyWith(error: "");
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: RoundedBackButton(),
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              clipBehavior: Clip.antiAlias,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(
                                widget.playlistDetails.image,
                                errorBuilder: (ctx, obj, stk) {
                                  return widget.favourites
                                      ? Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.favorite,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      )
                                      : Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color: AppColors.primary,
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.queue_music_outlined,
                                          size: 40,
                                          color: AppColors.primary,
                                        ),
                                      );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (ctx) => AudioPlayerScreen(
                                            songs: state.songs ?? [],
                                            index: 0,
                                          ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 5),
                            Text(
                              widget.playlistDetails.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      state.songs != null
                          ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.songs!.length,
                                itemBuilder: (ctx, index) {
                                  return popularItem(state.songs!, index);
                                },
                              ),
                            ),
                          )
                          : SizedBox(),
                    ],
                  ),
                  Visibility(visible: state.loading ?? false, child: Loader()),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: BlocBuilder<PlayerPositionBloc, PlayerCurrentState>(
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
                  ),

                ],
              );
            },
          ),
        ),
      ),
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

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => AudioPlayerScreen(songs: songs, index: index),
              ),
            );
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
              SizedBox(width: 40),
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
            ],
          ),
        ),
      ),
    );
  }
}
