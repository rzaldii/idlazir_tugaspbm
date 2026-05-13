import 'package:flutter/material.dart';

import '../models/product_model.dart';

import '../theme/app_colors.dart';
import '../theme/text_styles.dart';

import '../utils/format_currency.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  final VoidCallback onTap;
  final VoidCallback onSubmit;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onSubmit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.only(bottom: 20),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(24),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),

              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Hero(
              tag: product.id,

              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),

                child: Image.network(
                  'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085',

                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(product.name, style: AppTextStyles.subHeading),

                  const SizedBox(height: 8),

                  Text(
                    formatCurrency(product.price),

                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,

                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    product.description,

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    style: AppTextStyles.body,
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),

                          borderRadius: BorderRadius.circular(14),
                        ),

                        child: IconButton(
                          onPressed: onDelete,

                          icon: const Icon(
                            Icons.delete_outline,

                            color: Colors.red,
                          ),
                        ),
                      ),

                      const Spacer(),

                      ElevatedButton.icon(
                        onPressed: onSubmit,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,

                          elevation: 0,

                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),

                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                        ),

                        label: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
