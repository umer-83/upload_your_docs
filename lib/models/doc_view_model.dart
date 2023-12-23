class Document {
  final String id;
  final String text;
  final List<String> imageUrls;
  final List<String> pdfUrls;

  Document({
    required this.id,
    required this.text,
    required this.imageUrls,
    required this.pdfUrls,
  });
}
