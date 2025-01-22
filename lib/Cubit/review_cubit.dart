import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:filmku/Model/review.dart';
import 'package:filmku/Service/review_service.dart'; // Gantilah dengan nama path yang sesuai
import 'package:meta/meta.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewService _reviewService;

  ReviewCubit(this._reviewService) : super(ReviewInitial());

  // Method untuk mengambil data review berdasarkan movieId
  Future<void> fetchReviews(int movieId) async {
    emit(ReviewLoading());  // Mengubah state menjadi loading
    try {
      // Memanggil service untuk mendapatkan daftar review
      final List<Review> reviews = await _reviewService.fetchMovieReview(movieId);
      emit(ReviewLoaded(reviews));  // Jika berhasil, update state menjadi ReviewLoaded
    } catch (e) {
      emit(ReviewError(e.toString()));  // Jika terjadi error, update state menjadi ReviewError
    }
  }
}
