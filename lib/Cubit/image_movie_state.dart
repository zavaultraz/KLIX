part of 'image_movie_cubit.dart';

@immutable
sealed class ImageMovieState extends Equatable {
  const ImageMovieState();

  @override
  List<Object?> get props => [];
}

// ImageMovieInitial: digunakan saat aplikasi sedang dalam keadaan awal
final class ImageMovieInitial extends ImageMovieState {
  @override
  List<Object?> get props => [];
}

// ImageMovieLoading: saat data sedang dimuat
final class ImageMovieLoading extends ImageMovieState {}

// ImageMovieLoaded: ketika data gambar berhasil dimuat
final class ImageMovieLoaded extends ImageMovieState {
  final List<ImageMovie> images;

  ImageMovieLoaded(this.images);

  @override
  List<Object?> get props => [images];
}

// ImageMovieError: saat terjadi error dalam pengambilan data
final class ImageMovieError extends ImageMovieState {
  final String message;

  ImageMovieError(this.message);

  @override
  List<Object?> get props => [message];
}
