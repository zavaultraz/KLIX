  import 'package:filmku/Model/credits.dart';
  import 'package:http/http.dart' as http;
  import 'dart:convert';

  class CreditsService {
    final String baseUrl = 'https://api.themoviedb.org/3/movie';
    final String apiKey = '6a5a897293bae390c8913426115ecda1'; // Gantilah dengan API key Anda yang sesungguhnya

    // Method untuk mengambil detail credits film berdasarkan movie_id
    Future<List<Credits>> fetchMovieCredit(int movieId) async {
      final String url = '$baseUrl/$movieId/credits?api_key=$apiKey';
      final response = await http.get(Uri.parse(url));
  
      // Mengecek apakah response sukses (status code 200)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Mengambil data cast dan mengubahnya menjadi List<Credits>
        List<dynamic> castData = data['cast']; // cast adalah bagian dari response JSON
        List<Credits> creditsList = castData.map((actor) => Credits.fromJson(actor)).toList();

        return creditsList;
      } else {
        throw Exception('Gagal memuat credit film');
      }
    }
  }
