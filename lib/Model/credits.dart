import 'package:equatable/equatable.dart';
import 'package:flutter/src/widgets/container.dart';

class Credits extends Equatable {
  final int? id;
  final String? name;
  final String? image;
  final String? character;

  const Credits({
    this.id,
    this.name,
    this.image,
    this.character,
  });

  factory Credits.fromJson(Map<String, dynamic> data) {
    return Credits(
      id: data['id'],
      name: data['name'],
      image: data['profile_path'],
      character: data['character'],
    );
  }

  @override
  List<Object?> get props => [id, name, image, character];

}
