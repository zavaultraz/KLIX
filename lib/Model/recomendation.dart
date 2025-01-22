import 'package:equatable/equatable.dart';

class Recommendation extends Equatable {
  final int? id;
  final String? title;
  final String? posterPath;

  const Recommendation({
    this.id,
    this.title,
    this.posterPath,
  });

  factory Recommendation.fromJson(Map<String, dynamic> data) {
    return Recommendation(
      id: data['id'],
      title: data['title'],
      posterPath: data['poster_path'],
    );
  }

  @override
  List<Object?> get props => [id, title, posterPath];
}
