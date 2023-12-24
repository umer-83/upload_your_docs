import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/doc_view_model.dart';
import '../models/doc_view_provider.dart';
import 'doc_detail_screen.dart';
import 'home_screen.dart';

class DocumentListScreen extends StatelessWidget {
  const DocumentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document List'),
        backgroundColor: const Color(0xFF1D2C60),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeScreen(
                        userUid: '',
                      )),
            );
          },
        ),
      ),
      body: FutureBuilder<List<Document>>(
        future: Provider.of<DocumentProvider>(context, listen: false)
            .getDocuments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading documents'));
          } else {
            List<Document> documents = snapshot.data ?? [];
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Document ID: ${documents[index].id}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DocumentDetailScreen(document: documents[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
