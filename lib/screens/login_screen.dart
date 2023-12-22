import 'package:flutter/material.dart';
import 'package:upload_your_docs/widgets/email_text_widget.dart';
import 'package:upload_your_docs/widgets/password_text_widget.dart';
import '../models/auth_model_login.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2C60),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/app_logo.png',
                height: 280,
                width: 280,
              ),
              const SizedBox(height: 20),
              EmailTextField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              PasswordTextField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  AuthService authService = AuthService();
                  try {
                    String? userId =
                        await authService.signInWithEmailAndPassword(
                      email,
                      password,
                    );

                    if (userId != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(userUid: userId),
                        ),
                      );
                    } else {
                      // Show a snackbar for unsuccessful login
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Login failed. Please check your credentials.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  } catch (error) {
                    // Show a snackbar with the error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login failed: $error'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Text('Login'),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text('Sign Up'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forget-password');
                    },
                    child: Text('Forget Password?'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
