import 'package:flutter/material.dart';
import 'package:upload_your_docs/screens/pdf_viewer_screen.dart';
import '../models/doc_view_model.dart';

class DocumentDetailScreen extends StatelessWidget {
  final Document document;

  const DocumentDetailScreen({required this.document, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Detail'),
        backgroundColor: const Color(0xFF1D2C60),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Text:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(document.text, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Images:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // Display images
            for (String imageUrl in document.imageUrls)
              Image.network(imageUrl, height: 100),
            const SizedBox(height: 20),
            const Text('PDFs:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // Display PDFs
            for (String pdfUrl in document.pdfUrls)
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomPDFViewer(pdfUrl: pdfUrl),
                    ),
                  );
                },
                child: const Text('PDF Link'),
              ),
          ],
        ),
      ),
    );
  }
}
