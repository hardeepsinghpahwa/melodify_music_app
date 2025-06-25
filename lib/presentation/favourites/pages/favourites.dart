import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/helpers/is_dark_mode.dart';
import 'package:music_app/common/widgets/loader.dart';
import 'package:music_app/core/configs/assets/app_images.dart';
import 'package:music_app/presentation/favourites/bloc/favourites_bloc.dart';

import '../../../common/utils.dart';
import '../../../common/widgets/inputField.dart';
import '../../../common/widgets/text_button.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/song/playlist.dart';
import '../../../services.dart';
import '../../playlistDetails/pages/playlistDetails.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  TextEditingController playlistNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setFavSongs();
  }

  setFavSongs() async {
    sl<FavouritesBloc>().add(GetAllFavouritesEvent());
    sl<FavouritesBloc>().add(GetMyPlaylistsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FavouritesBloc, FavouritesState>(
        listener: (context, state) {
          if (state.backPress) {
            if (context.mounted) {
              Navigator.pop(context);
              sl<FavouritesBloc>().add(ResetEvents());
            }
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "My Playlists",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:
                                context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        Spacer(),
                        Image.asset(AppImages.logo, width: 40),
                      ],
                    ),
                    SizedBox(height: 20),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: state.songFavourites != null,
                              child: Column(
                                children: [
                                  playlistItem(
                                    Playlist("My Favourites", "", ""),
                                    isFav: true,
                                    count: (state.songFavourites ?? []).length,
                                  ),

                                  Divider(color: AppColors.lightGrey),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                newPlaylistDialog();
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  //border: Border.all(color: AppColors.primary),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "New Playlist",
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            state.isLoading ?? true
                                ? SizedBox()
                                : state.myPlaylists != null &&
                                    state.myPlaylists!.isNotEmpty
                                ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state.myPlaylists!.length,
                                  itemBuilder: (
                                    BuildContext context,
                                    int index,
                                  ) {
                                    return playlistItem(
                                      state.myPlaylists![index],
                                      count:
                                          (state.myPlaylists![index].songs ??
                                                  [])
                                              .length,
                                    );
                                  },
                                )
                                : Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 100.0),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          AppImages.noData,
                                          width: 200,
                                        ),
                                        Text("No Favourites Yet!"),
                                      ],
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(visible: state.isLoading ?? false, child: Loader()),
            ],
          );
        },
      ),
    );
  }

  Widget playlistItem(Playlist playlist, {bool isFav = false, int count = 0}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
      child: Material(
        color: context.isDarkMode ? Colors.grey : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (ctx) => PlaylistDetails(playlistDetails: playlist,favourites: isFav,),
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
                child:
                    !isFav
                        ? Image.network(
                          playlist.image,
                          width: 50,
                          height: 50,
                          errorBuilder: (ctx, obj, stk) {
                            return Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                              ),
                              child: Icon(
                                Icons.queue_music_outlined,
                                size: 40,
                                color: Colors.white,
                              ),
                            );
                          },
                        )
                        : Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.favorite,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(playlist.name),
                  Text(
                    count == 1 ? "$count song" : "$count Song",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  newPlaylistDialog() {
    playlistNameController.clear();
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            child: BlocBuilder<FavouritesBloc, FavouritesState>(
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
                                sl<FavouritesBloc>().add(
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
}
