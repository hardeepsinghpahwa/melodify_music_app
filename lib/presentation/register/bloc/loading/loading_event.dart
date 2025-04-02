part of 'loading_bloc.dart';

@immutable
sealed class LoadingEvent {}

class LoadingStartEvent extends LoadingEvent {}

class LoadingStopEvent extends LoadingEvent {}