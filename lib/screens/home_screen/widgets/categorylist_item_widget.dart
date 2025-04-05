import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/screens/products_list_screen/products_list_screen.dart';
import 'package:flutter/material.dart';

class CategorylistItemWidget extends StatelessWidget {
  final String iconPath;
  final String name;
  final EdgeInsetsGeometry? margin;
  final double? iconSize;
  final double? spacing;

  const CategorylistItemWidget({
    Key? key,
    required this.iconPath,
    required this.name,
    this.margin,
    this.iconSize = 24.0,
    this.spacing = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ProductsListScreen(),
        ));
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: margin ?? EdgeInsets.only(top: spacing!),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImageView(
                imagePath: iconPath,
                height: iconSize,
                width: iconSize,
              ),
              SizedBox(
                  height: spacing), // Spacing between the icon and the text
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium, // Use dynamic text style
              ),
            ],
          ),
        ),
      ),
    );
  }
}
