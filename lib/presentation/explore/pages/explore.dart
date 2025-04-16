import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/presentation/explore/bloc/explore_bloc.dart';

import '../../../common/widgets/searchField.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/song/song.dart';
import '../../../services.dart';
import '../../player/player.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),

                SearchInputField(
                  hint: "What song are you looking for?",
                  input: TextInputType.text,
                  controller: searchController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter search text";
                    }
                    return null;
                  },
                  onSubmit: (searchText) {
                    if (searchText.isNotEmpty) {
                      sl<ExploreBloc>().add(SearchEvent(searchText));
                    }
                  },
                ),
                SizedBox(height: 10,),
                if (state.loading == true)
                  Center(child: CircularProgressIndicator(color: AppColors.primary,))
                else
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return searchItem(state.filteredSongs ?? [], index, context);
                      },
                      itemCount: (state.filteredSongs ?? []).length,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget searchItem(List<SongEntity> songs, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Material(
        color: Colors.white,
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
                SizedBox(width: 5,),
                Image.network(songs[index].image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,),
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
                      ),
                    ),
                    Text(
                      maxLines: 1,
                      songs[index].artist,
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                Spacer(),
                Text(songs[index].duration.toString()),
                SizedBox(width: 20,),
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
