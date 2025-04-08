import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/configs/assets/app_images.dart';
import 'package:music_app/presentation/favourites/bloc/favourites_bloc.dart';

import '../../../common/utils.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../services.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    super.initState();
    setFavSongs();
  }

  setFavSongs() async {
    sl<FavouritesBloc>().add(GetAllFavouritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BlocBuilder<FavouritesBloc, FavouritesState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Your Favourites",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    state.songFavourites != null &&
                            state.songFavourites!.isNotEmpty
                        ? Expanded(
                          child: ListView.builder(
                            itemBuilder: (ctx, index) {
                              var item = state.songFavourites![index];
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {

                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(5.0),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Image.network(
                                            item.image,
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                          ),
                                        ),

                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.title,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                item.artist,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Utils.showBottomDialog(
                                              "Remove from favourites?",
                                              context,
                                            );
                                          },
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: state.songFavourites!.length,
                          ),
                        )
                        : SizedBox(),
                  ],
                ),
                Visibility(
                  visible: state.isLoading ?? false,
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.green),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
