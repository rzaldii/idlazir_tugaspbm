import 'package:flutter/material.dart';

import '../theme/text_styles.dart';

class EmptyWidget extends StatelessWidget {
  final String message;

  const EmptyWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset(
              'assets/images/empty.png',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 20),

            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),
          ],
        ),
      ),
    );
  }
}
