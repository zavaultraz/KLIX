import 'package:bloc/bloc.dart';
import 'package:filmku/Model/movie.dart';
import 'package:filmku/Service/movie_endpoints.dart';
import 'package:filmku/Service/service.dart';
import 'package:meta/meta.dart';

part 'soonmovie_state.dart';

class SoonmovieCubit extends Cubit<SoonmovieState> {
  final MovieService movieService;

  SoonmovieCubit(this.movieService) : super(SoonmovieInitial());

  Future<void> fetchSoonMovies() async {
    try {
      emit(SoonmovieInitial());
      // Mengambil daftar film yang akan datang (soon)
      final movies = await movieService.fetchMovies(MovieEndpoints.upcoming); // Pastikan `soonPlaying` adalah endpoint yang sesuai
      emit(SoonmovieLoaded(movies)); // Emit daftar film yang sudah di-load
    } catch (e) {
      emit(SoonmovieError(e.toString()));
    }
  }
}

