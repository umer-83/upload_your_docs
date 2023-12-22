import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../models/upload_model.dart';
import '../models/upload_provider.dart';
import '../screens/login_screen.dart'; // Import your login screen

class HomeScreen extends StatefulWidget {
  final String userUid;

  const HomeScreen({required this.userUid, Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Reference to the FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _textController = TextEditingController();
  final List<String> _imageUrls = [];
  final List<String> _pdfUrls = [];

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
            // Add widgets for uploading images and PDFs
            // ...

            ElevatedButton(
              onPressed: () async {
                final activityProvider =
                    Provider.of<ActivityProvider>(context, listen: false);

                final newActivity = Activity(
                  id: DateTime.now().toString(),
                  text: _textController.text,
                  imageUrls: _imageUrls,
                  pdfUrls: _pdfUrls,
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
}
