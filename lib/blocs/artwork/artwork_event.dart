part of 'artwork_bloc.dart';

@immutable
abstract class ArtworkEvent {
  const ArtworkEvent();
}

class GetArtwork extends ArtworkEvent {
  const GetArtwork(this.id);
  final int id;
}
