import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:filmku/Model/video.dart';
import 'package:filmku/Service/videos_service.dart';
import 'package:meta/meta.dart';
part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final VideoService _videoService;

  VideoCubit(this._videoService) : super(VideoInitial());

  // Method untuk mengambil data video berdasarkan movieId
  Future<void> fetchVideos(int movieId) async {
    emit(VideoLoading());  // Mengubah state menjadi loading
    try {
      // Memanggil service untuk mendapatkan daftar video
      final List<Video> videos = await _videoService.fetchVideos(movieId);
      emit(VideoLoaded(videos));  // Jika berhasil, update state menjadi VideoLoaded
    } catch (e) {
      emit(VideoError(e.toString()));  // Jika terjadi error, update state menjadi VideoError
    }
  }
}