import 'package:bloc/bloc.dart';
import 'package:filmku/Model/movie.dart';
import 'package:filmku/Service/movie_endpoints.dart';
import 'package:filmku/Service/service.dart';


part 'topmovie_state.dart';

class TopmovieCubit extends Cubit<TopmovieState> {
  final MovieService movieService;
  TopmovieCubit(this.movieService) : super(TopmovieInitial());
  Future<void> fetchTopMovies() async {
    try {
      emit(TopmovieInitial());
      // Mengambil daftar film populer
      final movies = await movieService.fetchMovies(MovieEndpoints.topRated);
      emit(TopmovieLoaded(movies)); // Emit daftar film yang sudah di-load
    } catch (e) {
      emit(TopmovieError(e.toString()));
    }
  }
}
