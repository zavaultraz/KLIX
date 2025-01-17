import 'package:bloc/bloc.dart';
import 'package:filmku/Model/movie.dart';
import 'package:filmku/Service/movie_endpoints.dart';
import 'package:filmku/Service/service.dart';
import 'package:meta/meta.dart';

part 'nowmovie_state.dart';

class NowmovieCubit extends Cubit<NowmovieState> {
  final MovieService movieService;
  NowmovieCubit(this.movieService) : super(NowmovieInitial());
  Future<void> fetchNowMovies() async {
    try {
      emit(NowmovieInitial());
      // Mengambil daftar film populer
      final movies = await movieService.fetchMovies(MovieEndpoints.nowPlaying);
      emit(NowmovieLoaded(movies)); // Emit daftar film yang sudah di-load
    } catch (e) {
      emit(NowmovieError(e.toString()));
    }
  }
}
