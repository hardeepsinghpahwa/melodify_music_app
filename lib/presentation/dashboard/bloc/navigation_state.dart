part of 'navigation_cubit.dart';

@immutable
sealed class NavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

final class NavigationHome extends NavigationState {}

final class NavigationExplore extends NavigationState {}

final class NavigationFav extends NavigationState {}

final class NavigationProfile extends NavigationState {}
