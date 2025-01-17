part of 'topmovie_cubit.dart';

sealed class TopmovieState {
  const TopmovieState();

  @override
  List<Object> get props => [];
}

final class TopmovieInitial extends TopmovieState {
  @override
  List<Object> get props => [];
}

final class TopmovieLoaded extends TopmovieState {
  final List<Movie> movies; // Ganti Movie dengan List<Movie>

  TopmovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

// TopmovieError: saat terjadi error dalam pengambilan data
final class TopmovieError extends TopmovieState {
  final String message;

  TopmovieError(this.message);

  @override
  List<Object> get props => [message];
}
