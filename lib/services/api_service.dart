class ApiService {
  static const String baseUrl =
      'https://task.itprojects.web.id/api';

  static Map<String, String> headers({
    String? token,
  }) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null)
        'Authorization': 'Bearer $token',
    };
  }

  static Uri url(String endpoint) {
    return Uri.parse('$baseUrl$endpoint');
  }
}