part of 'explore_bloc.dart';

@immutable
sealed class ExploreEvent {}

class SearchEvent extends ExploreEvent {
  final String searchText;

  SearchEvent(this.searchText);
}

class RecentSearchesEvent extends ExploreEvent {}

class ChangeSearchFocusEvent extends ExploreEvent {
  final bool focusValue;

  ChangeSearchFocusEvent(this.focusValue);
}

class RemoveRecentSearchEvent extends ExploreEvent {
  final String value;

  RemoveRecentSearchEvent(this.value);
}

