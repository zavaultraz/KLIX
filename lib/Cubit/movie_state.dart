part of 'movie_cubit.dart';

sealed class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

// MovieInitial: digunakan saat aplikasi sedang dalam keadaan awal
final class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

// MovieLoaded: ketika data film berhasil dimuat
final class MovieLoaded extends MovieState {
  final List<Movie> movies; // Ganti Movie dengan List<Movie>

  MovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

// MovieError: saat terjadi error dalam pengambilan data
final class MovieError extends MovieState {
  final String message;

  MovieError(this.message);

  @override
  List<Object> get props => [message];
}
