part of 'nowmovie_cubit.dart';

@immutable
sealed class NowmovieState {
const NowmovieState();
  @override
  List<Object> get props => [];
}

final class NowmovieInitial extends NowmovieState {
  @override
  List<Object> get props => [];
}

final class NowmovieLoaded extends NowmovieState {
  final List<Movie> movies; // Ganti Movie dengan List<Movie>

  NowmovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

// MovieError: saat terjadi error dalam pengambilan data
final class NowmovieError extends NowmovieState {
  final String message;

  NowmovieError(this.message);

  @override
  List<Object> get props => [message];
}
