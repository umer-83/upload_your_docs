import 'package:flutter/material.dart';
import '../models/auth_model_signup.dart';
import '../widgets/email_text_widget.dart';
import '../widgets/password_text_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  AuthServiceSignUp authServiceSignUp = AuthServiceSignUp();
                  try {
                    String? userId =
                        await authServiceSignUp.signUpWithEmailAndPassword(
                      email, // Use the email variable
                      password, // Use the password variable
                    );

                    if (userId != null) {
                      // Show a snackbar for successful signup
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sign up successful. User ID: $userId'),
                          duration: Duration(seconds: 3),
                        ),
                      );

                      // Navigate to the home screen with the user ID
                      Navigator.pushNamed(context, '/home', arguments: userId);
                    } else {
                      // Show a snackbar for unsuccessful signup
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sign up failed. Please try again.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  } catch (error) {
                    // Show a snackbar with the error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Sign up failed: $error'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Text('Sign Up'),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Login'),
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
