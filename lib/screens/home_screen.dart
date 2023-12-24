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
import 'doc_list_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userUid;

  const HomeScreen({required this.userUid, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _textController = TextEditingController();
  final List<String> _imageUrls = [];
  final PdfPickerService _pdfPickerService = PdfPickerService();
  final PdfUploaderService _pdfUploaderService = PdfUploaderService();
  List<String> _selectedPdfUrls = [];
  final ImagePickerService _imagePickerService = ImagePickerService();
  final ImageUploaderService _imageUploaderService = ImageUploaderService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: const Color(0xFF1D2C60),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
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
              decoration: const InputDecoration(labelText: 'Text'),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                List<String> pickedImages =
                    await _imagePickerService.pickImages();
                setState(() {
                  _imageUrls.addAll(pickedImages);
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue, // Adjust the color as needed
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
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
                  const SizedBox(height: 16),
                  const Text('Selected Images:'),
                  for (String imageUrl in _imageUrls) Text(imageUrl),
                ],
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _selectedPdfUrls = await _pdfPickerService.pickPdfFiles();
                setState(() {});
              },
              child: const Text('Pick PDF'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final activityProvider =
                    Provider.of<ActivityProvider>(context, listen: false);

                GlobalKey<State> key = GlobalKey<State>();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return WillPopScope(
                      onWillPop: () async => false,
                      child: SimpleDialog(
                        key: key,
                        children: const [
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    );
                  },
                );

                try {
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

                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DocumentListScreen(),
                    ),
                  );
                } catch (error) {
                  print('Error during upload: $error');
                } finally {
                  Navigator.of(key.currentContext!).pop();
                }
              },
              child: const Text('Upload'),
            ),

            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DocumentListScreen(),
                  ),
                );
              },
              child: const Text('View Uploaded Docs'),
            ),
          ],
        ),
      ),
    );
  }
}
