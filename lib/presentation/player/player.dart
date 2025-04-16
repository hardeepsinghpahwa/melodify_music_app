import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/widgets/back_button.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/presentation/player/bloc/player_position/player_position_bloc.dart';

import '../../common/utils.dart';
import '../../core/configs/theme/app_colors.dart';
import '../../services.dart';

class AudioPlayerScreen extends StatefulWidget {
  final List<SongEntity> songs;
  final int index;
  final bool play;

  const AudioPlayerScreen({
    required this.songs,
    required this.index,
    this.play = true,
    super.key,
  });

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final player = sl<AudioPlayer>();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    playSong();
  }

  playSong() async {
    if (widget.play) {
      sl<PlayerPositionBloc>().add(PlayerPlayChangeEvent(true));
    }
    if (player.source != null &&
        (player.source as UrlSource).url != widget.songs[currentIndex].link) {
      sl<PlayerPositionBloc>().add(ChangeSongEvent(widget.songs, currentIndex));
      await player.play(UrlSource(widget.songs[currentIndex].link));
    } else {
      if (player.state != PlayerState.playing) {
        sl<PlayerPositionBloc>().add(
          ChangeSongEvent(widget.songs, currentIndex),
        );
        await player.play(UrlSource(widget.songs[currentIndex].link));
      }
    }

    player.getDuration().then((value) {
      sl<PlayerPositionBloc>().add(
        PlayerDurationChangeEvent(value!.inSeconds.toDouble()),
      );
    });

    player.onPositionChanged.listen((duration) {
      sl<PlayerPositionBloc>().add(
        PlayerPositionChangeEvent(duration.inSeconds.toDouble()),
      );

      if (duration.inSeconds == (sl<PlayerPositionBloc>().state.duration + 1)) {
        if (currentIndex != widget.songs.length - 1) {
          changeSong(widget.songs, currentIndex + 1);
        } else {
          changeSong(widget.songs, 0);
        }
      }
    });

    sl<PlayerPositionBloc>().add(
      CheckFavouriteEvent(widget.songs[currentIndex].id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocListener<PlayerPositionBloc, PlayerCurrentState>(
            listener: (context, state) {
              if (state.error != null) {
                Utils.showErrorSnackbar(state.error ?? "Error", context);
              }
              if (state.success != null) {
                Utils.showSuccessSnackbar(state.success ?? "Success", context);
              }
            },
            child: BlocBuilder<PlayerPositionBloc, PlayerCurrentState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      children: [
                        RoundedBackButton(),
                        Spacer(),
                        Text(
                          "Now Playing",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        //Image.asset(AppImages.dotMenu, height: 30),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child:
                            (state.currentSong?.image ?? "").isNotEmpty
                                ? Image.network(
                                  state.currentSong?.image ?? "",
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.center,
                                )
                                : Icon(Icons.music_note),
                      ),
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 1,
                              state.currentSong?.title ?? "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              maxLines: 1,
                              state.currentSong?.artist ?? "",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    Column(
                      children: [
                        SliderTheme(
                          data: SliderThemeData(
                            thumbColor: Colors.green,
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 8,
                            ),
                          ),
                          child: Slider(
                            allowedInteraction: SliderInteraction.tapAndSlide,
                            padding: EdgeInsets.zero,
                            activeColor: AppColors.green,
                            value: state.position.toDouble(),
                            min: 0.0,
                            max: state.duration.toDouble() + 1,
                            onChanged: (value) {
                              if (player.source == null) {
                                player.setSource(
                                  UrlSource(widget.songs[currentIndex].link),
                                );
                              }
                              player.seek(Duration(seconds: value.toInt()));
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(getTime(state.position.toDouble())),
                            Text(state.currentSong?.duration ?? ""),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.repeat, size: 30),
                        GestureDetector(
                          onTap: () {
                            int nextIndex = 0;
                            if (currentIndex != 0) {
                              nextIndex = currentIndex - 1;
                            } else {
                              nextIndex = widget.songs.length - 1;
                            }
                            currentIndex = nextIndex;
                            changeSong(widget.songs, nextIndex);
                          },
                          child: Icon(
                            Icons.arrow_circle_left_outlined,
                            size: 30,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            player.resume();
                            if (player.state == PlayerState.playing) {
                              sl<PlayerPositionBloc>().add(
                                PlayerPlayChangeEvent(false),
                              );
                              player.pause();
                            } else {
                              sl<PlayerPositionBloc>().add(
                                PlayerPlayChangeEvent(true),
                              );
                              if (player.source == null) {
                                await player.play(
                                  UrlSource(widget.songs[currentIndex].link),
                                );
                              } else {
                                player.resume();
                              }
                            }
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.green,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              !state.isPlaying ? Icons.play_arrow : Icons.pause,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            int nextIndex = 0;
                            if (currentIndex != widget.songs.length - 1) {
                              nextIndex = currentIndex + 1;
                            }
                            currentIndex = nextIndex;
                            changeSong(widget.songs, nextIndex);
                          },
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 30,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            sl<PlayerPositionBloc>().add(
                              FavouriteEvent(
                                !state.favourite,
                                state.currentSong?.id ?? "",
                              ),
                            );
                          },
                          child: Icon(
                            state.favourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: state.favourite ? Colors.red : Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  changeSong(List<SongEntity> songs, int nextIndex) {
    player.play(UrlSource(songs[nextIndex].link));
    sl<PlayerPositionBloc>().add(ChangeSongEvent(songs, nextIndex));
  }

  String getTime(double seconds) {
    final duration = Duration(seconds: seconds.toInt());
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final secs = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$secs";
  }
}
