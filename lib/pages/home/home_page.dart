import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/product_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../../widgets/product_card.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/search_bar_widget.dart';
import 'product_detail_page.dart';
import 'add_product_page.dart';
import '../auth/login_page.dart';
import '../submit/submit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> filteredProducts = [];

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final provider = context.read<ProductProvider>();

      await provider.getProducts();

      filteredProducts = provider.products;

      setState(() {});
    });
  }

  void searchProduct(String query) {
    final provider = context.read<ProductProvider>();

    setState(() {
      filteredProducts = provider.products
          .where(
            (product) =>
                product.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  Future<void> refreshData() async {
    final provider = context.read<ProductProvider>();

    await provider.getProducts();

    filteredProducts = provider.products;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,

        child: const Icon(Icons.add, color: Colors.white),

        onPressed: () {
          Navigator.push(
            context,

            MaterialPageRoute(builder: (_) => const AddProductPage()),
          );
        },
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Daftar Produk Kopi',
                                style: AppTextStyles.heading,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Manajemen data produk kopi.',
                                style: AppTextStyles.body,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  IconButton(
                    onPressed: () async {
                      final confirm = await showDialog(
                        context: context,

                        builder: (_) => AlertDialog(
                          title: const Text('Logout'),

                          content: const Text('Yakin ingin logout?'),

                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },

                              child: const Text('Batal'),
                            ),

                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },

                              child: const Text('Logout'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await context.read<AuthProvider>().logout();

                        if (!mounted) return;

                        Navigator.pushReplacement(
                          context,

                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      }
                    },

                    icon: const Icon(Icons.logout_rounded),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              SearchBarWidget(onChanged: searchProduct),

              const SizedBox(height: 24),

              Expanded(
                child: provider.isLoading
                    ? const LoadingWidget()
                    : filteredProducts.isEmpty
                    ? const EmptyWidget(message: 'Tidak ditemukan produk kopi.')
                    : RefreshIndicator(
                        color: AppColors.primary,

                        onRefresh: refreshData,

                        child: ListView.builder(
                          itemCount: filteredProducts.length,

                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];

                            return ProductCard(
                              product: product,

                              onTap: () {
                                Navigator.push(
                                  context,

                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ProductDetailPage(product: product),
                                  ),
                                );
                              },

                              onSubmit: () {
                                Navigator.push(
                                  context,

                                  MaterialPageRoute(
                                    builder: (_) =>
                                        SubmitPage(product: product),
                                  ),
                                );
                              },

                              onDelete: () async {
                                final confirm = await showDialog(
                                  context: context,

                                  builder: (_) => AlertDialog(
                                    title: const Text('Hapus Produk'),

                                    content: const Text(
                                      'Yakin ingin hapus produk ini?',
                                    ),

                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },

                                        child: const Text('Batal'),
                                      ),

                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },

                                        child: const Text('Hapus'),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Soft delete success'),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
