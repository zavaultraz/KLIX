import 'package:filmku/Model/video.dart'; // Pastikan untuk mengimpor model Video
import 'package:http/http.dart' as http;
import 'dart:convert';

class VideoService {
  final String baseUrl = 'https://api.themoviedb.org/3/movie';
  final String apiKey = '6a5a897293bae390c8913426115ecda1'; // Gantilah dengan API key Anda yang sesungguhnya

  // Method untuk mengambil video berdasarkan movie_id
  Future<List<Video>> fetchVideos(int movieId) async {
    final String url = '$baseUrl/$movieId/videos?api_key=$apiKey&language=en-US';
    final response = await http.get(Uri.parse(url));

    // Mengecek apakah response sukses (status code 200)
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Mengambil data results dan mengubahnya menjadi List<Video>
      List<dynamic> videosData = data['results']; // results adalah bagian dari response JSON
      List<Video> videoList = videosData.map((video) => Video.fromJson(video)).toList();

      return videoList;
    } else {
      throw Exception('Gagal memuat video');
    }
  }
}