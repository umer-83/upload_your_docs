import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'doc_view_model.dart';

class DocumentProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Document>> getDocuments() async {
    try {
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot querySnapshot = await _firestore
          .collection('activities')
          .where("uid", isEqualTo: currentUserId)
          .get();
      List<Document> documents = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        Document document = Document(
          id: doc.id,
          text: data['text'] ?? '',
          imageUrls: List<String>.from(data['imageUrls'] ?? []),
          pdfUrls: List<String>.from(data['pdfUrls'] ?? []),
        );

        documents.add(document);
      }

      return documents;
    } catch (e) {
      print('Error getting documents: $e');
      // Handle error (show a snackbar, retry, etc.)
      return [];
    }
  }
}
