part of 'soonmovie_cubit.dart';

@immutable
sealed class SoonmovieState {
  const SoonmovieState();

  @override
  List<Object> get props => [];
}

final class SoonmovieInitial extends SoonmovieState {
  @override
  List<Object> get props => [];
}

final class SoonmovieLoaded extends SoonmovieState {
  final List<Movie> movies; // Ganti Movie dengan List<Movie>

  SoonmovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

// SoonmovieError: saat terjadi error dalam pengambilan data
final class SoonmovieError extends SoonmovieState {
  final String message;

  SoonmovieError(this.message);

  @override
  List<Object> get props => [message];
}
