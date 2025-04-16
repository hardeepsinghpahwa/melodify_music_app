part of 'explore_bloc.dart';

@immutable
sealed class ExploreEvent {

}

class SearchEvent extends ExploreEvent{

  final String searchText;

  SearchEvent(this.searchText);
}
