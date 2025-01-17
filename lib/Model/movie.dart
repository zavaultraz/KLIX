
import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int? id;
  final String? title;
  final String? overview;
  final String? image;
  final String? release;
  final double? rating;
  final String? poster;
  final List<String>? genre;

  const Movie({
    this.id,
    this.title,
    this.overview,
    this.image,
    this.release,
    this.rating,
    this.poster,
    this.genre,
  });

  factory Movie.fromJson(Map<String, dynamic> data) => Movie(
    id: data["id"],
    title: data["title"],
    overview: data["overview"],
    poster: data["poster_path"],
    image: data["backdrop_path"],
    release: data["release_date"],
    rating: data["vote_average"],
    genre: List<String>.from(data["genre_ids"].map((x) => x.toString())),
  );

  @override
  List<Object?> get props => [
    id,
    title,
    overview,
    poster,
    image,
    release,
    rating,
    genre,
  ];
}