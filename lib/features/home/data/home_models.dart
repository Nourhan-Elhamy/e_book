class BookModel {
  final String title;
  final String thumbnail;
  final String authors;
  final String previewLink;
  final String description;
  final String publisher;
  final String publishedDate;
  final List<String> categories;

  BookModel({
    required this.title,
    required this.thumbnail,
    required this.authors,
    required this.previewLink,
    required this.description,
    required this.publisher,
    required this.publishedDate,
    required this.categories,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final info = json['volumeInfo'];
    return BookModel(
      title: info['title'] ?? 'No Title',
      thumbnail: info['imageLinks']?['thumbnail'] ?? '',
      authors: (info['authors'] as List?)?.join(', ') ?? 'Unknown Author',
      previewLink: info['previewLink'] ?? '',
      description: info['description'] ?? 'No Description Available.',
      publisher: info['publisher'] ?? 'Unknown Publisher',
      publishedDate: info['publishedDate'] ?? 'Unknown Date',
      categories: (info['categories'] as List?)?.cast<String>() ?? [],
    );
  }
}
