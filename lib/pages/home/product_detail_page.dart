import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../../utils/format_currency.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Stack(
              children: [
                Hero(
                  tag: product.id,

                  child: Image.network(
                    'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085',

                    height: 350,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: Container(
                      padding: const EdgeInsets.all(8),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              transform: Matrix4.translationValues(0, -30, 0),

              padding: const EdgeInsets.all(24),

              decoration: const BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(product.name, style: AppTextStyles.heading),

                  const SizedBox(height: 12),

                  Text(
                    formatCurrency(product.price),

                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,

                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text('Description', style: AppTextStyles.subHeading),

                  const SizedBox(height: 10),

                  Text(product.description, style: AppTextStyles.body),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
