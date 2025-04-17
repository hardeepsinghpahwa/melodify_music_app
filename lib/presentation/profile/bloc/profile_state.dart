part of 'profile_bloc.dart';

@immutable
class ProfileState {
  final UserEntity? entity;
  final bool loader;
  final bool retry;

  const ProfileState({this.entity, this.loader=false, this.retry=false});

  ProfileState copyWith({
    UserEntity? entity,
    bool? loader,
    bool? retry,
  }) {
    return ProfileState(
      entity: entity ?? this.entity,
      loader: loader ?? this.loader,
      retry: retry ?? this.retry,
    );
  }
}
