class Review {
  final String author;
  final String content;
  final String? avatarPath;
  final double? rating;
  final String url;

  Review({
    required this.author,
    required this.content,
    this.avatarPath,
    this.rating,
    required this.url,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      author: json['author'],
      content: json['content'],
      avatarPath: json['author_details']['avatar_path'],
      rating: json['author_details']['rating']?.toDouble(),
      url: json['url'],
    );
  }
}
