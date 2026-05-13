import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../theme/text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  Future<void> addProduct() async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Semua field wajib diisi')));

      return;
    }

    setState(() {
      isLoading = true;
    });

    final success = await context.read<ProductProvider>().addProduct(
      name: nameController.text,

      price: int.parse(priceController.text),

      description: descriptionController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produk berhasil ditambahkan')),
      );

      Navigator.pop(context);
    } else {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Gagal menambah produk')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Produk Kopi', style: AppTextStyles.subHeading),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [
            CustomTextField(
              hintText: 'Product Name',
              controller: nameController,
              prefixIcon: Icons.coffee,
            ),

            const SizedBox(height: 20),

            CustomTextField(
              hintText: 'Price',
              controller: priceController,
              prefixIcon: Icons.attach_money,

              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: descriptionController,

              maxLines: 5,

              decoration: InputDecoration(
                hintText: 'Description',
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: 'Tambah',

              isLoading: isLoading,

              onPressed: addProduct,
            ),
          ],
        ),
      ),
    );
  }
}
