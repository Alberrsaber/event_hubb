import 'package:flutter/material.dart';
import '../my_theme.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "EventHub",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: MyTheme.white,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.notifications, color: MyTheme.white),
          onPressed: () {},
        ),
      ],
    );
  }
}
