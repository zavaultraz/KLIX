part of 'video_cubit.dart';

@immutable
sealed class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object?> get props => [];
}

// VideoInitial: digunakan saat aplikasi sedang dalam keadaan awal
final class VideoInitial extends VideoState {
  @override
  List<Object?> get props => [];
}

// VideoLoading: saat data sedang dimuat
final class VideoLoading extends VideoState {}

// VideoLoaded: ketika data video berhasil dimuat
final class VideoLoaded extends VideoState {
  final List<Video> videos;

  VideoLoaded(this.videos);

  @override
  List<Object?> get props => [videos];
}

// VideoError: saat terjadi error dalam pengambilan data
final class VideoError extends VideoState {
  final String message;

  VideoError(this.message);

  @override
  List<Object?> get props => [message];
}