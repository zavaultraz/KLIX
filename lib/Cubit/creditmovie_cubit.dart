import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:filmku/Model/credits.dart';
import 'package:filmku/Service/credits_service.dart';
import 'package:meta/meta.dart';

part 'creditmovie_state.dart';

class CreditsMovieCubit extends Cubit<CreditsState> {
  final CreditsService credService;

  CreditsMovieCubit(this.credService) : super(CreditsInitial());

  // Method untuk mengambil detail film berdasarkan movieId
  // Fetch movie credits based on movieId
  Future<void> fetchCredits(int movieId) async {
    emit(CreditsLoading()); // Set loading state

    try {
      final credits = await credService.fetchMovieCredit(movieId);
      emit(CreditsLoaded(credits)); // Successfully loaded credits
    } catch (e) {
      emit(CreditsError('Failed to load credits: $e')); // Error state
    }
  }
}