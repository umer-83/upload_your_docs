import 'package:flutter/material.dart';
import '../models/auth_model_signup.dart';
import '../widgets/email_text_widget.dart';
import '../widgets/password_text_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sign up successful. User ID: $userId'),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, '/home', arguments: userId);
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
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
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text('Login'),
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
