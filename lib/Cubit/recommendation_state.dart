part of 'recommendation_cubit.dart';

@immutable
sealed class RecommendationState extends Equatable {
  const RecommendationState();

  @override
  List<Object?> get props => [];
}

// RecommendationInitial: digunakan saat aplikasi sedang dalam keadaan awal
final class RecommendationInitial extends RecommendationState {
  @override
  List<Object?> get props => [];
}

// RecommendationLoading: saat data sedang dimuat
final class RecommendationLoading extends RecommendationState {}

// RecommendationLoaded: ketika data rekomendasi berhasil dimuat
final class RecommendationLoaded extends RecommendationState {
  final List<Recommendation> recommendations;

  RecommendationLoaded(this.recommendations);

  @override
  List<Object?> get props => [recommendations];
}

// RecommendationError: saat terjadi error dalam pengambilan data
final class RecommendationError extends RecommendationState {
  final String message;

  RecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}
