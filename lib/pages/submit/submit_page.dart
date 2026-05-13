import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../providers/product_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../../utils/format_currency.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class SubmitPage extends StatefulWidget {
  final ProductModel product;

  const SubmitPage({super.key, required this.product});

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  final TextEditingController githubController = TextEditingController();

  bool isLoading = false;

  Future<void> submitTask() async {
    if (githubController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,

          backgroundColor: AppColors.error,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          content: const Text('GitHub repository wajib diisi'),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    final success = await context.read<ProductProvider>().submitProduct(
      name: widget.product.name,

      price: widget.product.price,

      description: widget.product.description,

      githubUrl: githubController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,

          backgroundColor: AppColors.primary,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          content: const Text('Tugas berhasil dikirim ☕'),
        ),
      );

      Navigator.pop(context);
    } else {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,

          backgroundColor: AppColors.error,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          content: const Text('Gagal submit tugas'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Product', style: AppTextStyles.subHeading),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text('Final Review ☕', style: AppTextStyles.heading),

            const SizedBox(height: 8),

            Text(
              'Pastikan data produk dan repository GitHub sudah benar sebelum submit.',
              style: AppTextStyles.body,
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),

                    blurRadius: 10,
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),

                    child: Image.network(
                      'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085',

                      height: 180,
                      width: double.infinity,

                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(widget.product.name, style: AppTextStyles.subHeading),

                  const SizedBox(height: 10),

                  Text(
                    formatCurrency(widget.product.price),

                    style: const TextStyle(
                      fontSize: 18,

                      fontWeight: FontWeight.bold,

                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(widget.product.description, style: AppTextStyles.body),
                ],
              ),
            ),

            const SizedBox(height: 30),

            CustomTextField(
              hintText: 'GitHub Repository URL',

              controller: githubController,

              prefixIcon: Icons.link,
            ),

            const SizedBox(height: 40),

            CustomButton(
              text: 'Submit Now',

              isLoading: isLoading,

              onPressed: submitTask,
            ),
          ],
        ),
      ),
    );
  }
}
