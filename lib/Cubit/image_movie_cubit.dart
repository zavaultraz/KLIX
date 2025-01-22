
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:filmku/Model/imageMovie.dart';
import 'package:filmku/Service/imageMovie_service.dart';
import 'package:meta/meta.dart';

part 'image_movie_state.dart';

class ImageMovieCubit extends Cubit<ImageMovieState> {
  final ImageMovieService _imageMovieService;

  ImageMovieCubit(this._imageMovieService) : super(ImageMovieInitial());

  // Method untuk mengambil data gambar berdasarkan movieId
  Future<void> fetchImages(int movieId) async {
    emit(ImageMovieLoading());  // Mengubah state menjadi loading
    try {
      // Memanggil service untuk mendapatkan daftar gambar
      final List<ImageMovie> images = await _imageMovieService.fetchImages(movieId);
      emit(ImageMovieLoaded(images));  // Jika berhasil, update state menjadi ImageMovieLoaded
    } catch (e) {
      emit(ImageMovieError(e.toString()));  // Jika terjadi error, update state menjadi ImageMovieError
    }
  }
}
