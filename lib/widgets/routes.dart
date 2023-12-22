import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  RoutesState createState() => RoutesState();
}

class RoutesState extends State<Routes> {
  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
  }

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {});
    } catch (e) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (context) => const LoginScreen());
          case '/signup':
            return MaterialPageRoute(
                builder: (context) => const SignUpScreen());
          case '/home':
            return MaterialPageRoute(
              builder: (context) {
                final userUid = settings.arguments as String?;
                return HomeScreen(userUid: userUid ?? '');
              },
            );
          default:
            return null;
        }
      },
    );
  }
}
