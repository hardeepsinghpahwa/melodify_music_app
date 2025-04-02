part of 'loading_bloc.dart';

@immutable
sealed class LoadingState {}

final class LoadingInitial extends LoadingState {}

final class LoadingProgressState extends LoadingState {}

final class LoadingIdleState extends LoadingState {}
