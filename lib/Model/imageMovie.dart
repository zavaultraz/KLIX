import 'package:equatable/equatable.dart';

class ImageMovie extends Equatable {
  final int? id;
  final String? image;

  const ImageMovie({
    this.id,
    this.image,
  });

  factory ImageMovie.fromJson(Map<String, dynamic> data) => ImageMovie(
    id: data['id'],
    image: data['file_path'],
  );

  @override
  List<Object?> get props => [
    id,
    image,
  ];
}