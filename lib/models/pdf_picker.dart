import 'package:file_picker/file_picker.dart';

class PdfPickerService {
  Future<List<String>> pickPdfFiles() async {
    List<String> pdfPaths = [];

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true, // Allow multiple file selection
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        pdfPaths = result.paths.cast<String>();
      }
    } catch (e) {
      // ignore: avoid_print
      print('PDF picking error: $e');
    }

    return pdfPaths;
  }
}
