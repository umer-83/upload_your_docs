import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upload_your_docs/models/upload_model.dart';

class ActivityService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadActivity(Activity activity) async {
    await _firestore.collection('activities').doc(activity.id).set({
      'uid': FirebaseAuth.instance.currentUser?.uid,
      'text': activity.text,
      'imageUrls': activity.imageUrls,
      'pdfUrls': activity.pdfUrls,
    });
  }
}
