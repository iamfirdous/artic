part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  const SearchEvent();
}

class GetResults extends SearchEvent {
  const GetResults(this.query, [this.loadMore = false]);
  final String query;
  final bool loadMore;
}
