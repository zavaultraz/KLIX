// detail_movie_state.dart
part of 'detailmovie_cubit.dart';
sealed class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object> get props => [];
}

// DetailMovieInitial: digunakan saat aplikasi sedang dalam keadaan awal
final class DetailMovieInitial extends DetailMovieState {
  @override
  List<Object> get props => [];
}

// DetailMovieLoading: saat data sedang dimuat
final class DetailMovieLoading extends DetailMovieState {}

// DetailMovieLoaded: ketika detail film berhasil dimuat
final class DetailMovieLoaded extends DetailMovieState {
  final Detail detailMovie;

  DetailMovieLoaded(this.detailMovie);

  @override
  List<Object> get props => [detailMovie];
}

// DetailMovieError: saat terjadi error dalam pengambilan data
final class DetailMovieError extends DetailMovieState {
  final String message;

  DetailMovieError(this.message);

  @override
  List<Object> get props => [message];
}
