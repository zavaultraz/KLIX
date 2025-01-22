import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:filmku/Model/credits.dart';
import 'package:filmku/Service/credits_service.dart'; // pastikan import service yang benar
import 'package:meta/meta.dart';

part 'creditmovie_state.dart';

class CreditsCubit extends Cubit<CreditsState> {
  final CreditsService _creditsService;

  CreditsCubit(this._creditsService) : super(CreditsInitial());

  // Method untuk mengambil data credits berdasarkan movieId
  Future<void> fetchCredits(int movieId) async {
    emit(CreditsLoading()); // Mengubah state menjadi loading
    try {
      // Memanggil service untuk mendapatkan daftar cast (credits)
      final List<Credits> creditsList = await _creditsService.fetchMovieCredit(movieId);
      emit(CreditsLoaded(creditsList)); // Jika berhasil, update state menjadi CreditsLoaded
    } catch (e) {
      emit(CreditsError(e.toString())); // Jika terjadi error, update state menjadi CreditsError
    }
  }
}
