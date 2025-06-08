import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class CategorieslistItemWidget extends StatelessWidget {
  final String label; // Text label for the item
  final String imagePath; // Image path for the icon
  final VoidCallback onTap; // Callback for item click

  const CategorieslistItemWidget({
    Key? key,
    required this.label,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle item click
      child: SizedBox(
        width: 70.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 70.h,
              decoration: BoxDecoration(
                color: appTheme.blueGray50,
                borderRadius: BorderRadiusStyle.roundedBorder34,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomImageView(
                    imagePath: imagePath, // Use the dynamic image path
                    height: 68.h,
                    width: 68.h,
                    radius: BorderRadius.circular(34.h),
                  ),
                ],
              ),
            ),
            Text(
              label, // Use the dynamic label
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.bodyMediumErrorContainer3,
            ),
          ],
        ),
      ),
    );
  }
}
