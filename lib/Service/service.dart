import 'package:filmku/Model/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieService {
  final String baseUrl = 'https://api.themoviedb.org/3/movie';
  final String apiKey = '6a5a897293bae390c8913426115ecda1'; // Gantilah dengan API key Anda yang sesungguhnya

  // Method untuk mengambil film berdasarkan path endpoint (misalnya 'popular', 'top_rated', dll)
  Future<List<Movie>> fetchMovies(String path) async {
    final String url = '$baseUrl/$path?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    // Mengecek apakah response sukses (status code 200)
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Menyusun daftar Movie berdasarkan response API
      List<Movie> movies = (data['results'] as List)
          .map((movieData) => Movie.fromJson(movieData))
          .toList();

      return movies;
    } else {
      throw Exception('Gagal memuat daftar film');
    }
  }
}
