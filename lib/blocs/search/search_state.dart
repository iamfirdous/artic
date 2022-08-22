part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchResults extends SearchState {
  const SearchResults(this.data, this.query, [this.isLoadingMore = false, this.allLoaded = false]);
  final List<Data> data;
  final String query;
  final bool isLoadingMore;
  final bool allLoaded;
}

class SearchError extends SearchState {
  const SearchError(this.error);
  final String error;
}
