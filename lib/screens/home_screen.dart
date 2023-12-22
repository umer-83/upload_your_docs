import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          // Add a logout button to the app bar
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // Sign out the user from Firebase
              await _auth.signOut();

              // Navigate back to the login screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('User UID: ${widget.userUid}'),
      ),
    );
  }
}
