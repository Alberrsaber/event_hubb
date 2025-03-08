import 'package:flutter/material.dart';
import '../my_theme.dart';
import '../models/tab_item_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_search_container.dart';

class TopContainer extends StatelessWidget {
  final List<TabItemModel> tabItemsList;

  const TopContainer({
    super.key,
    required this.tabItemsList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
        color: MyTheme.primaryColor,
      ),
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomAppBar(),
          const CustomSearchContainer(),
          // If TabItemsList widget exists, use it here
          // TabItemsList(tabItemsList: tabItemsList),
        ],
      ),
    );
  }
}
