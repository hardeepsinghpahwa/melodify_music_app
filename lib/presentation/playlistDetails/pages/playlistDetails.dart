import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/helpers/is_dark_mode.dart';
import 'package:music_app/common/utils.dart';
import 'package:music_app/common/widgets/loader.dart';
import 'package:music_app/presentation/playlistDetails/playlistDetailsBloc/playlist_details_bloc.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/song/playlist.dart';
import '../../../domain/entities/song/song.dart';
import '../../../services.dart';
import '../../player/player.dart';

class PlaylistDetails extends StatefulWidget {
  final Playlist playlistDetails;

  const PlaylistDetails({super.key, required this.playlistDetails});

  @override
  State<PlaylistDetails> createState() => _PlaylistDetailsState();
}

class _PlaylistDetailsState extends State<PlaylistDetails> {
  @override
  void initState() {
    super.initState();
    sl<PlaylistDetailsBloc>().add(LoadPlaylistSongs(widget.playlistDetails.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    BackButton(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Image.network(
                                  widget.playlistDetails.image,
                                  width: 100,
                                  height: 100,
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
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.songs!.length,
                            itemBuilder: (ctx, index) {
                              return popularItem(state.songs!, index);
                            },
                          ),
                        )
                        : SizedBox(),
                  ],
                ),
                Visibility(visible: state.loading ?? false, child: Loader()),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget popularItem(List<SongEntity> songs, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 5),
      child: Material(
        color: context.isDarkMode ? Colors.transparent : Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
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
      ),
    );
  }
}
