import 'package:flutter/material.dart';
import 'package:upload_your_docs/models/upload_model.dart';
import 'package:upload_your_docs/models/upload_service.dart';

class ActivityProvider with ChangeNotifier {
  final ActivityService _activityService = ActivityService();

  Future<void> uploadActivity(Activity activity) async {
    await _activityService.uploadActivity(activity);
    notifyListeners();
  }
}
