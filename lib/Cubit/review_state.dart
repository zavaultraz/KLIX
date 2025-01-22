part of 'review_cubit.dart';

@immutable
sealed class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object?> get props => [];
}

// ReviewInitial: digunakan saat aplikasi sedang dalam keadaan awal
final class ReviewInitial extends ReviewState {
  @override
  List<Object?> get props => [];
}

// ReviewLoading: saat data sedang dimuat
final class ReviewLoading extends ReviewState {}

// ReviewLoaded: ketika data review berhasil dimuat
final class ReviewLoaded extends ReviewState {
  final List<Review> reviews;

  ReviewLoaded(this.reviews);

  @override
  List<Object?> get props => [reviews];
}

// ReviewError: saat terjadi error dalam pengambilan data
final class ReviewError extends ReviewState {
  final String message;

  ReviewError(this.message);

  @override
  List<Object?> get props => [message];
}
