class BookAPIs {
  final String id;
  final String title;
  final String coverImageUrl;
  final List<String> authors;
  final String description;
  final String filePath;

  BookAPIs({
    required this.id,
    required this.title,
    required this.coverImageUrl,
    required this.authors,
    required this.description,
    required this.filePath,
  });

  factory BookAPIs.fromJson(Map<String, dynamic> json) {
    String id = json['id'] as String;
    String title = json['volumeInfo']['title'] is String
        ? json['volumeInfo']['title'] as String
        : '';
    List<String> titleWords = title.split(' ');
    if (titleWords.length > 6) {
      title = '${titleWords.take(6).join(' ')}...';
    }

    List<String> authors = json['volumeInfo']['authors'] is List<String>
        ? List<String>.from(json['volumeInfo']['authors'])
        : [];

    return BookAPIs(
      id: id,
      title: title,
      coverImageUrl: json['volumeInfo']['imageLinks'] != null &&
              json['volumeInfo']['imageLinks']['thumbnail'] is String
          ? json['volumeInfo']['imageLinks']['thumbnail'] as String
          : 'default_image_url_or_empty_string',
      authors: authors,
      description: json['volumeInfo']['description'] is String
          ? json['volumeInfo']['description'] as String
          : 'No description available',
      filePath: '',
    );
  }
}
