import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/widgets/back_button.dart';
import 'package:music_app/core/configs/assets/app_images.dart';
import 'package:music_app/domain/entities/song/song.dart';
import 'package:music_app/presentation/player/bloc/player_position/player_position_bloc.dart';
import 'package:music_app/presentation/player/bloc/player_state/player_state_cubit.dart';

import '../../core/configs/theme/app_colors.dart';
import '../../services.dart';

class AudioPlayerScreen extends StatefulWidget {
  final SongEntity song;

  const AudioPlayerScreen({required this.song, super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  double _currentValue = 20;
  final player = sl<AudioPlayer>();
  Duration? _duration;

  @override
  void initState() {
    super.initState();
    playSong();
  }

  playSong() async {
    sl<PlayerStateCubit>().play();
    if (player.state != PlayerState.playing) {
      await player.play(UrlSource(widget.song.link));
    }

    player.getDuration().then(
      (value) => setState(() {
        _duration = value;
        print("DURATION ${_duration}");
      }),
    );

    player.onPositionChanged.listen((duration) {
      sl<PlayerPositionBloc>().add(
        PlayerPositionChangeEvent(duration.inSeconds.toDouble()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  RoundedBackButton(),
                  Spacer(),
                  Text(
                    "Now Playing",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Image.asset(AppImages.dotMenu, height: 30),
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    widget.song.image,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.center,
                  ),
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
                        widget.song.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        maxLines: 1,
                        widget.song.artist,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Icon(Icons.favorite, color: AppColors.grey, size: 20),
                ],
              ),

              SizedBox(height: 20),

              BlocBuilder<PlayerPositionBloc, PlayerPositionState>(
                builder: (context, state) {

                  return Column(
                    children: [
                      Slider(
                        allowedInteraction: SliderInteraction.tapAndSlide,
                        padding: EdgeInsets.zero,
                        activeColor: AppColors.green,

                        value: state is PlayerPositionChangeState? state.currentIndex:0,
                        min: 0.0,
                        max: 200,
                        onChanged: (value) {
                          final duration = _duration;
                          if (duration == null) {
                            return;
                          }
                          final position = value * duration.inMilliseconds;
                          player.seek(
                            Duration(milliseconds: position.round()),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(getTime(state is PlayerPositionChangeState? state.currentIndex:0)),
                          Text(widget.song.duration),
                        ],
                      ),
                    ],
                  );
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.repeat, size: 30),
                  Icon(Icons.arrow_circle_left_outlined, size: 30),
                  BlocBuilder<PlayerStateCubit, PlayerStateState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          if (player.state == PlayerState.playing) {
                            sl<PlayerStateCubit>().pause();
                            player.pause();
                          } else {
                            sl<PlayerStateCubit>().play();
                            player.resume();
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
                            state is PlayerStateStopped
                                ? Icons.play_arrow
                                : Icons.pause,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      );
                    },
                  ),
                  Icon(Icons.arrow_circle_right_outlined, size: 30),
                  Icon(Icons.shuffle, size: 30),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String getTime(double seconds) {
    final duration = Duration(seconds: seconds.toInt());
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final secs = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$secs";
  }
}
