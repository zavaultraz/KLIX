import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:filmku/Service/movie_endpoints.dart';
import 'package:meta/meta.dart';
import 'package:filmku/Model/movie.dart';
import '../Service/service.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieService movieService;

  MovieCubit(this.movieService) : super(MovieInitial());

  // Method untuk mengambil film populer
  Future<void> fetchPopularMovies() async {
    try {
      emit(MovieInitial());
      // Mengambil daftar film populer
      final movies = await movieService.fetchMovies(MovieEndpoints.popular);
      emit(MovieLoaded(movies)); // Emit daftar film yang sudah di-load
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }



}

