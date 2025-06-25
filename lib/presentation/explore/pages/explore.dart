import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/helpers/is_dark_mode.dart';
import 'package:music_app/presentation/explore/bloc/explore_bloc.dart';

import '../../../common/widgets/loader.dart';
import '../../../common/widgets/searchField.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/song/song.dart';
import '../../../services.dart';
import '../../player/player.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FocusNode searchFocusNode = FocusNode();

    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        debugPrint("CHANGE FOCUS TRUE");
        sl<ExploreBloc>().add(ChangeSearchFocusEvent(true));
      } else {
        debugPrint("CHANGE FOCUS FALSE");
        sl<ExploreBloc>().add(ChangeSearchFocusEvent(false));
      }
    });

    sl<ExploreBloc>().add(RecentSearchesEvent());

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "What are you in mood for?",
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
                      SizedBox(height: 15),

                      SearchInputField(
                        hint: "Search for songs, playlists, artists",
                        input: TextInputType.text,
                        controller: searchController,
                        validator: (val) {
                          return null;
                        },
                        focusNode: searchFocusNode,
                        onSubmit: (searchText) {
                          if (searchText.isNotEmpty) {
                            searchFocusNode.unfocus();
                            sl<ExploreBloc>().add(SearchEvent(searchText));
                          }
                        },
                      ),
                      SizedBox(height: 20),

                      state.searchFocus || (state.filteredSongs??[]).isEmpty
                          ? Column(
                            children: [
                              (state.recentSearches ?? []).isNotEmpty
                                  ? Column(
                                    children: [
                                      Text("RECENT SEARCHES"),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        height: 25,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (ctx, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                sl<ExploreBloc>().add(
                                                  SearchEvent(
                                                    state
                                                        .recentSearches![index],
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 25,
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 0.5,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 5),
                                                      Text(
                                                        state
                                                            .recentSearches![index],
                                                        style: TextStyle(
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      GestureDetector(
                                                        onTap: () {
                                                          sl<ExploreBloc>().add(
                                                            RemoveRecentSearchEvent(
                                                              state
                                                                  .recentSearches![index],
                                                            ),
                                                          );
                                                        },
                                                        child: Icon(
                                                          Icons.clear,
                                                          size: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount:
                                              (state.recentSearches ?? [])
                                                  .length,
                                        ),
                                      ),
                                    ],
                                  )
                                  : SizedBox(),
                              SizedBox(height: 10),
                            ],
                          )
                          : Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return searchItem(
                                  state.filteredSongs ?? [],
                                  index,
                                  context,
                                );
                              },
                              itemCount: (state.filteredSongs ?? []).length,
                            ),
                          ),
                    ],
                  ),
                ),
                Visibility(visible: state.loading, child: Loader()),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget searchItem(List<SongEntity> songs, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( bottom: 5),
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
                SizedBox(width: 20),
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
                SizedBox(width: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
