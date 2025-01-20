import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:filmku/Model/Detail.dart';
import 'package:filmku/Service/details_service.dart';
import 'package:meta/meta.dart';

part 'detailmovie_state.dart';

class DetailMovieCubit extends Cubit<DetailMovieState> {
  final DetailsService detailService;

  DetailMovieCubit(this.detailService) : super(DetailMovieInitial());

  // Method untuk mengambil detail film berdasarkan movieId
  Future<void> fetchDetailMovie(int movieId) async {
    try {
      emit(
          DetailMovieLoading()); // Mengubah state menjadi loading sebelum mengambil data
      final detailMovie = await detailService.fetchMovieDetail(movieId);
      emit(DetailMovieLoaded(
          detailMovie)); // Mengubah state menjadi DetailMovieLoaded jika data berhasil
    } catch (e) {
      emit(DetailMovieError(e
          .toString())); // Mengubah state menjadi DetailMovieError jika terjadi kesalahan
    }
  }
}