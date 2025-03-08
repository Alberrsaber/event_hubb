import 'package:flutter/material.dart';

class TabItemModel {
  final String title;
  final Color backgroundColor;

  TabItemModel({
    required this.title,
    required this.backgroundColor, // 🔥 Make sure backgroundColor is required
  });
}
