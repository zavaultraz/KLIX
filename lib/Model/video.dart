// video.dart
class Video {
  final String iso6391; // ISO 639-1 language code
  final String iso3166_1; // ISO 3166-1 country code
  final String name; // Name of the video
  final String key; // Key for the video (YouTube ID)
  final String site; // Site where the video is hosted (e.g., YouTube)
  final int size; // Size of the video
  final String type; // Type of the video (e.g., Teaser, Trailer)
  final bool official; // Whether the video is official
  final DateTime publishedAt; // Date the video was published
  final String id; // Unique identifier for the video

  Video({
    required this.iso6391,
    required this.iso3166_1,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      iso6391: json['iso_639_1'] as String,
      iso3166_1: json['iso_3166_1'] as String,
      name: json['name'] as String,
      key: json['key'] as String,
      site: json['site'] as String,
      size: json['size'] as int,
      type: json['type'] as String,
      official: json['official'] as bool,
      publishedAt: DateTime.parse(json['published_at'] as String),
      id: json['id'] as String,
    );
  }
}