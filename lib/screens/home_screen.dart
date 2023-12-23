import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../models/image_picker.dart';
import '../models/image_upload.dart';
import '../models/pdf_picker.dart';
import '../models/pdf_upload.dart';
import '../models/upload_model.dart';
import '../models/upload_provider.dart';
import '../screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userUid;

  const HomeScreen({required this.userUid, Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _textController = TextEditingController();
  final List<String> _imageUrls = [];
  final List<String> _pdfUrls = [];
  final PdfPickerService _pdfPickerService = PdfPickerService();
  final PdfUploaderService _pdfUploaderService = PdfUploaderService();
  List<String> _selectedPdfUrls = [];
  final ImagePickerService _imagePickerService = ImagePickerService();
  final ImageUploaderService _imageUploaderService = ImageUploaderService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Text'),
            ),
            InkWell(
              onTap: () async {
                List<String> pickedImages =
                    await _imagePickerService.pickImages();
                setState(() {
                  _imageUrls.addAll(pickedImages);
                });
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue, // Adjust the color as needed
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.image,
                  size: 36, // Adjust the size as needed
                  color: Colors.white, // Icon color
                ),
              ),
            ),
            // Display the selected image paths (optional)
            if (_imageUrls.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text('Selected Images:'),
                  for (String imageUrl in _imageUrls) Text(imageUrl),
                ],
              ),
            ElevatedButton(
              onPressed: () async {
                _selectedPdfUrls = await _pdfPickerService.pickPdfFiles();
                setState(() {});
              },
              child: Text('Pick PDFs'),
            ),
            ElevatedButton(
              onPressed: () async {
                final activityProvider =
                    Provider.of<ActivityProvider>(context, listen: false);

                List<String> uploadedPdfUrls =
                    await _pdfUploaderService.uploadPdfs(_selectedPdfUrls);
                List<String> uploadedImageUrls =
                    await _imageUploaderService.uploadImages(_imageUrls);
                final newActivity = Activity(
                  id: DateTime.now().toString(),
                  text: _textController.text,
                  imageUrls: uploadedImageUrls,
                  pdfUrls: uploadedPdfUrls,
                );

                await activityProvider.uploadActivity(newActivity);

                // Optionally, navigate to a different screen after upload
                Navigator.pop(context);
              },
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAndUploadImages() async {
    final List<String> selectedImageUrls =
        await _imagePickerService.pickImages();
    setState(() {
      _imageUrls.addAll(selectedImageUrls);
    });

    await _imageUploaderService.uploadImages(selectedImageUrls);
  }
}
