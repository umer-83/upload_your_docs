import 'package:flutter/material.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';

class CustomPDFViewer extends StatefulWidget {
  final String pdfUrl;

  const CustomPDFViewer({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomPDFViewerState createState() => _CustomPDFViewerState();
}

class _CustomPDFViewerState extends State<CustomPDFViewer> {
  late PDFDocument? document;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initialisePdf();
  }

  void initialisePdf() async {
    try {
      document = await PDFDocument.fromURL(widget.pdfUrl);
    } catch (e) {
      print('Error loading PDF: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        backgroundColor: const Color(0xFF1D2C60),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : document != null
              ? PDFViewer(document: document!)
              : const Center(child: Text('Error loading PDF')),
    );
  }
}
