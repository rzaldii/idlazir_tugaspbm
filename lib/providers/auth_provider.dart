import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

class AuthProvider extends ChangeNotifier {

  final AuthService _authService =
      AuthService();

  bool isLoading = false;

  String? token;

  Future<bool> login({
    required String username,
    required String password,
  }) async {

    try {

      isLoading = true;
      notifyListeners();

      final response =
          await _authService.login(
        username: username,
        password: password,
      );

      token = response.token;

      await StorageService.saveToken(
        response.token,
      );

      return true;

    } catch (e) {

      debugPrint(e.toString());

      return false;

    } finally {

      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    token = null;

    await StorageService.deleteToken();

    notifyListeners();
  }
}