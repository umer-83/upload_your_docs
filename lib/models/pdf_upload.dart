import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class PdfUploaderService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> uploadPdfs(List<String> pdfPaths) async {
    List<String> pdfUrls = [];

    for (String path in pdfPaths) {
      File file = File(path);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      try {
        TaskSnapshot taskSnapshot =
            await _storage.ref('pdf/$fileName.pdf').putFile(file);
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        pdfUrls.add(downloadUrl);
      } on FirebaseException catch (e) {
        // ignore: avoid_print
        print('PDF upload failed: $e');
        // Handle error (show a snackbar, retry, etc.)
      }
    }

    return pdfUrls;
  }
}
