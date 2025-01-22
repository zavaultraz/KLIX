import 'package:filmku/Model/review.dart'; // Gantilah dengan model Review Anda
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewService {
  final String baseUrl = 'https://api.themoviedb.org/3/movie';
  final String apiKey = '6a5a897293bae390c8913426115ecda1'; // Gantilah dengan API key Anda yang sesungguhnya

  // Method untuk mengambil review film berdasarkan movie_id
  Future<List<Review>> fetchMovieReview(int movieId) async {
    final String url = '$baseUrl/$movieId/reviews?api_key=$apiKey&language=en-US&page=1';
    final response = await http.get(Uri.parse(url));

    // Mengecek apakah response sukses (status code 200)
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Mengambil data results dan mengubahnya menjadi List<Review>
      List<dynamic> reviewsData = data['results']; // results adalah bagian dari response JSON
      List<Review> reviewList = reviewsData.map((review) => Review.fromJson(review)).toList();

      return reviewList;
    } else {
      throw Exception('Gagal memuat review film');
    }
  }
}
