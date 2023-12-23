import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploaderService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> uploadImages(List<String> imagePaths) async {
    List<String> downloadUrls = [];

    for (String path in imagePaths) {
      File file = File(path);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      try {
        TaskSnapshot taskSnapshot =
            await _storage.ref('images/$fileName').putFile(file);

        // Get the download URL for the uploaded image
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      } on FirebaseException catch (e) {
        print('Image upload failed: $e');
        // Handle error (show a snackbar, retry, etc.)
      }
    }

    return downloadUrls;
  }
}
