import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/doc_view_model.dart';
import '../models/doc_view_provider.dart';
import 'doc_detail_screen.dart';
import 'home_screen.dart';

class DocumentListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document List'),
        backgroundColor: const Color(0xFF1D2C60),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading documents'));
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
