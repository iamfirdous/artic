import 'package:artic/models/search_response.dart';
import 'package:artic/repositories/artwork_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<GetResults>(onGetResults);
  }

  final List<Data> results = [];
  String query = '';

  Future<void> onGetResults(GetResults event, Emitter<SearchState> emit) async {
    try {
      query = event.query;
      if (query.isEmpty) {
        results.clear();
        emit(SearchInitial());
      } else {
        emit(SearchLoading());
        if (event.loadMore) {
          emit(SearchResults(results, query, true));
        } else {
          results.clear();
        }
        final response = await ArtworkRepository.instance.search(query, results.length);
        if (response.query == query) {
          results.addAll(response.data ?? []);
          final allLoaded = response.pagination?.total == results.length;
          emit(SearchResults(results, query, false, allLoaded));
        }
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
