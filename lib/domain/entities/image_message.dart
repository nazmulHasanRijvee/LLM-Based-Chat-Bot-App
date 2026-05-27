class ImageMessage {

  final String role;
  final String prompt;
  final String? imageUrl;
  final String? textContent;
  final DateTime time;

  const ImageMessage({
    required this.role,
    required this.prompt,
    this.imageUrl,
    this.textContent,
    required this.time
  });

  bool get isUser => role == 'user';
  bool get hasImage => imageUrl != null;

}