import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import 'api_service.dart';

class ProductService {
  
  Future<List<ProductModel>> getProducts(String token) async {
    final response = await http.get(
      ApiService.url('/products'),

      headers: ApiService.headers(token: token),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List products = data['data']['products'];

      return products.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil produk');
    }
  }

  Future<void> addProduct({
    required String token,
    required String name,
    required int price,
    required String description,
  }) async {
    final response = await http.post(
      ApiService.url('/products'),

      headers: ApiService.headers(token: token),

      body: jsonEncode({
        'name': name,
        'price': price,
        'description': description,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal menambah produk');
    }
  }

  Future<void> submitProduct({
    required String token,
    required String name,
    required int price,
    required String description,
    required String githubUrl,
  }) async {
    final response = await http.post(
      ApiService.url('/products/submit'),

      headers: ApiService.headers(token: token),

      body: jsonEncode({
        'name': name,
        'price': price,
        'description': description,
        'github_url': githubUrl,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal submit tugas');
    }
  }
}
