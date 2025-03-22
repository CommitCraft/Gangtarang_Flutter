import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class BrandCategorieslistItemWidget extends StatefulWidget {
  final String label; // Text label for the item
  final String imagePath; // Image path for the icon
  final VoidCallback onTap; // Callback for item click

  BrandCategorieslistItemWidget({
    Key? key,
    required this.label,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  _BrandCategorieslistItemWidgetState createState() =>
      _BrandCategorieslistItemWidgetState();
}

class _BrandCategorieslistItemWidgetState
    extends State<BrandCategorieslistItemWidget> {
  bool selecter = false; // Track selection state

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selecter = !selecter; // Toggle the selection state on tap
        });
        widget.onTap(); // Call the onTap callback passed to the widget
      }, // Handle item click
      child: SizedBox(
        width: 45.h,
        child: Column(
          children: [
            Container(
              height: 45.h,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: appTheme.blueGray50,
                borderRadius: BorderRadiusStyle.roundedBorder34,
                border: Border.all(
                  color: selecter ? theme.primaryColor : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomImageView(
                    imagePath: widget.imagePath, // Use the dynamic image path
                    height: 37.h,
                    width: 37.h,
                    radius: BorderRadius.circular(34.h),
                  ),
                ],
              ),
            ),
            // Text(
            //   widget.label, // Use the dynamic label
            //   overflow: TextOverflow.ellipsis,
            //   style: CustomTextStyles.bodyMediumErrorContainer3,
            // ),
          ],
        ),
      ),
    );
  }
}
