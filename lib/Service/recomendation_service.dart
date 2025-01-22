import 'package:filmku/Model/recomendation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
 // Pastikan import model Recommendation

class RecommendationService {
  final String baseUrl = 'https://api.themoviedb.org/3/movie';
  final String apiKey = '6a5a897293bae390c8913426115ecda1'; // Gantilah dengan API key Anda yang sesungguhnya

  // Method untuk mengambil rekomendasi film berdasarkan movie_id
  Future<List<Recommendation>> fetchRecommendations(int movieId) async {
    final String url = '$baseUrl/$movieId/recommendations?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    // Mengecek apakah response sukses (status code 200)
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Mengambil data recommendations dan mengubahnya menjadi List<Recommendation>
      List<dynamic> recommendationsData = data['results'];  // results adalah bagian dari response JSON
      List<Recommendation> recommendationsList = recommendationsData
          .map((rec) => Recommendation.fromJson(rec))
          .toList();

      return recommendationsList;
    } else {
      throw Exception('Gagal memuat rekomendasi film');
    }
  }
}
