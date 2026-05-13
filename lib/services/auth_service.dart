import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_response_model.dart';
import 'api_service.dart';

class AuthService {
  Future<LoginResponseModel> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      ApiService.url('/auth/login'),

      headers: ApiService.headers(),

      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(data);
    } else {
      throw Exception(
        data['message'] ?? 'Login gagal',
      );
    }
  }
}