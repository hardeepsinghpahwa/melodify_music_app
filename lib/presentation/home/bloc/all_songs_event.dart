part of 'all_songs_bloc.dart';

@immutable
sealed class AllSongsEvent {}

class AllSongsLoadingEvent extends AllSongsEvent {}
