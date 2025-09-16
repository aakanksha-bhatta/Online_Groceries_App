import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingNotifier extends ChangeNotifier {
  bool _isLoading = false;
  bool _isUploading = false;

  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;

  Future<void> setUploading() async {
    _isUploading = !_isUploading;
    notifyListeners();
  }

  Future<void> setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}

final loadingProvider = ChangeNotifierProvider<LoadingNotifier>((ref) {
  return LoadingNotifier();
});
