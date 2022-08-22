import 'package:artic/models/artwork_response.dart';
import 'package:artic/repositories/artwork_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'artwork_event.dart';
part 'artwork_state.dart';

class ArtworkBloc extends Bloc<ArtworkEvent, ArtworkState> {
  ArtworkBloc() : super(ArtworkInitial()) {
    on<GetArtwork>(onGetArtwork);
  }

  Future<void> onGetArtwork(GetArtwork event, Emitter<ArtworkState> emit) async {
    try {
      emit(ArtworkLoading());
      final response = await ArtworkRepository.instance.getArtwork(event.id);
      if (response.artwork != null) {
        emit(ArtworkLoaded(response.artwork!));
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      emit(ArtworkError(e.toString()));
    }
  }
}
