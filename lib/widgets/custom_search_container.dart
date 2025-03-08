import 'package:flutter/material.dart';
import '../my_theme.dart';

class CustomSearchContainer extends StatelessWidget {
  const CustomSearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: MyTheme.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search events...",
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, color: MyTheme.grey),
        ),
      ),
    );
  }
}
