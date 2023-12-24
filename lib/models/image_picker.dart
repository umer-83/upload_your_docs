import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<List<String>> pickImages() async {
    List<String> imageUrls = [];

    final List<XFile> pickedImages =
        await _imagePicker.pickMultiImage(imageQuality: 70);

    if (pickedImages.isNotEmpty) {
      for (XFile image in pickedImages) {
        imageUrls.add(image.path);
      }
    }

    return imageUrls;
  }
}
