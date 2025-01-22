import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:filmku/Model/recomendation.dart';
import 'package:filmku/Service/recomendation_service.dart';
import 'package:meta/meta.dart';

part 'recommendation_state.dart';

class RecommendationCubit extends Cubit<RecommendationState> {
  final RecommendationService _recommendationService;

  RecommendationCubit(this._recommendationService) : super(RecommendationInitial());

  // Method untuk mengambil data rekomendasi berdasarkan movieId
  Future<void> fetchRecommendations(int movieId) async {
    emit(RecommendationLoading());  // Mengubah state menjadi loading
    try {
      // Memanggil service untuk mendapatkan daftar rekomendasi
      final List<Recommendation> recommendations = await _recommendationService.fetchRecommendations(movieId);
      emit(RecommendationLoaded(recommendations));  // Jika berhasil, update state menjadi RecommendationLoaded
    } catch (e) {
      emit(RecommendationError(e.toString()));  // Jika terjadi error, update state menjadi RecommendationError
    }
  }
}
