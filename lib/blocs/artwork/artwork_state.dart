part of 'artwork_bloc.dart';

@immutable
abstract class ArtworkState {
  const ArtworkState();
}

class ArtworkInitial extends ArtworkState {}

class ArtworkLoading extends ArtworkState {}

class ArtworkLoaded extends ArtworkState {
  const ArtworkLoaded(this.artwork);
  final Artwork artwork;
}

class ArtworkError extends ArtworkState {
  const ArtworkError(this.error);
  final String error;
}
