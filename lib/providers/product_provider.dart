import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';
import '../services/storage_service.dart';

class ProductProvider extends ChangeNotifier {

  final ProductService _productService =
      ProductService();

  List<ProductModel> products = [];

  bool isLoading = false;

  Future<void> getProducts() async {

    try {

      isLoading = true;
      notifyListeners();

      final token =
          await StorageService.getToken();

      if (token == null) return;

      products =
          await _productService.getProducts(
        token,
      );

    } catch (e) {

      debugPrint(e.toString());

    } finally {

      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addProduct({
    required String name,
    required int price,
    required String description,
  }) async {

    try {

      final token =
          await StorageService.getToken();

      if (token == null) return false;

      await _productService.addProduct(
        token: token,
        name: name,
        price: price,
        description: description,
      );

      await getProducts();

      return true;

    } catch (e) {

      debugPrint(e.toString());

      return false;
    }
  }

  Future<bool> submitProduct({
    required String name,
    required int price,
    required String description,
    required String githubUrl,
  }) async {

    try {

      final token =
          await StorageService.getToken();

      if (token == null) return false;

      await _productService.submitProduct(
        token: token,
        name: name,
        price: price,
        description: description,
        githubUrl: githubUrl,
      );

      return true;

    } catch (e) {

      debugPrint(e.toString());

      return false;
    }
  }
}