import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  bool isPasswordHidden = true;

  Future<void> login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,

          backgroundColor: AppColors.error,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          content: const Text('Semua textfield wajib diisi.'),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    final success = await context.read<AuthProvider>().login(
      username: usernameController.text,
      password: passwordController.text,
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

          content: const Text('Login berhasil ☕'),
        ),
      );

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,

          backgroundColor: AppColors.error,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          content: const Text('Username atau password salah.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),

                Text('IDLAZIR', style: AppTextStyles.heading),

                const SizedBox(height: 10),

                Text(
                  'Hallooww, Silahkan login terlebih dahulu.',

                  style: AppTextStyles.body,
                ),

                const SizedBox(height: 40),

                Container(
                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(28),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),

                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: 'Username',

                        controller: usernameController,

                        prefixIcon: Icons.person_outline,
                      ),

                      const SizedBox(height: 20),

                      CustomTextField(
                        hintText: 'Password',

                        controller: passwordController,

                        prefixIcon: Icons.lock_outline,

                        obscureText: isPasswordHidden,

                        suffixIcon: isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,

                        onSuffixTap: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                      ),

                      const SizedBox(height: 30),

                      CustomButton(
                        text: 'Login',

                        isLoading: isLoading,

                        onPressed: login,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
