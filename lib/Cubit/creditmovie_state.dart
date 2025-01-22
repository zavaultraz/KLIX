part of 'creditmovie_cubit.dart';

@immutable
sealed class CreditsState extends Equatable {
  const CreditsState();

  @override
  List<Object?> get props => [];
}

// CreditsInitial: digunakan saat aplikasi sedang dalam keadaan awal
final class CreditsInitial extends CreditsState {
  @override
  List<Object?> get props => [];
}

// CreditsLoading: saat data sedang dimuat
final class CreditsLoading extends CreditsState {}

// CreditsLoaded: ketika data credits berhasil dimuat
final class CreditsLoaded extends CreditsState {
  final List<Credits> credits; // Mengubah menjadi List<Credits>

  CreditsLoaded(this.credits);

  @override
  List<Object?> get props => [credits];
}

// CreditsError: saat terjadi error dalam pengambilan data
final class CreditsError extends CreditsState {
  final String message;

  CreditsError(this.message);

  @override
  List<Object?> get props => [message];
}
