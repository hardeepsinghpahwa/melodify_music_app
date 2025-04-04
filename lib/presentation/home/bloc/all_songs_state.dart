part of 'all_songs_bloc.dart';

@immutable
sealed class AllSongsState {}

final class AllSongsInitial extends AllSongsState {}

final class AllSongsLoading extends AllSongsState {}

final class AllSongsLoaded extends AllSongsState {
  final List<SongEntity> songs;

  AllSongsLoaded({required this.songs});
}

final class AllSongsLoadingFailed extends AllSongsState {
  final String error;

  AllSongsLoadingFailed({required this.error});
}
