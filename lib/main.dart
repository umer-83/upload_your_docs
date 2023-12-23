import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upload_your_docs/widgets/routes.dart';
import 'firebase_options.dart';
import 'models/doc_view_provider.dart';
import 'models/upload_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ActivityProvider>(
          create: (context) => ActivityProvider(),
        ),
        ChangeNotifierProvider<DocumentProvider>(
          create: (context) => DocumentProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Routes(),
    );
  }
}
