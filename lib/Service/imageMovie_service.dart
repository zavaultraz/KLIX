import 'package:filmku/Model/imageMovie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ImageMovieService {
  final String baseUrl = 'https://api.themoviedb.org/3/movie';
  final String apiKey = '6a5a897293bae390c8913426115ecda1'; // Gantilah dengan API key Anda yang sesungguhnya

  // Method untuk mengambil gambar film berdasarkan movie_id
  Future<List<ImageMovie>> fetchImages(int movieId) async {
    final String url = '$baseUrl/$movieId/images?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    // Mengecek apakah response sukses (status code 200)
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Mengambil data images dan mengubahnya menjadi List<ImageMovie>
      List<dynamic> imagesData = data['backdrops'];  // backdrops adalah bagian dari response JSON
      List<ImageMovie> imagesList = imagesData
          .map((img) => ImageMovie.fromJson(img))
          .toList();

      return imagesList;
    } else {
      throw Exception('Gagal memuat gambar film');
    }
  }
}
