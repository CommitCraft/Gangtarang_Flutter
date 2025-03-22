import 'package:amazmart/core/app_export.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BoxDecoration? boxDecoration;
  final bool? divider;
  final String title;
  final VoidCallback? onBackPressed;
  final VoidCallback? onRightBtnPressed;
  final int badgeCount; // Number of items in the wishlist
  final String rightIconPath; // Path for the wishlist icon
  final bool showBadge; // Determines if the badge should be displayed
  final bool rightBtn; // Determines if the badge should be displayed

  const CustomAppBar({
    Key? key,
    required this.title,
    this.boxDecoration,
    this.divider = true,
    this.onBackPressed,
    this.onRightBtnPressed,
    this.badgeCount = 0,
    this.rightIconPath = '', // Default wishlist icon path
    this.showBadge = false, // Default to hide badge
    this.rightBtn = false, // Default to hide badge
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      height: 60,
      width: double.maxFinite,
      decoration: boxDecoration ?? BoxDecoration(
        color: Colors.white, // Replace with your app's theme color
      ) ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildIconButton(
                  context: context,
                  iconPath: ImageConstant
                      .backIcon, // Replace with your back icon path
                  onPressed: onBackPressed ?? () => Navigator.pop(context),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium ,
                    ),
                  ),
                ),
                rightBtn ? _buildRightButton(context) : Container(),
              ],
            ),
          ),
          SizedBox(
            child: divider! ? Divider(
              height: 1,
              color: appTheme.indigo50,
            ):Container() ,
          ),
        ],
      ),
    );
  
  }

  Widget _buildIconButton({
    required BuildContext context,
    required String iconPath,
    required VoidCallback? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: IconButton(
        icon: CustomImageView(
          imagePath: iconPath,
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildRightButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: CustomImageView(imagePath: 
              rightIconPath,
              height: 20,
              width: 20,
              color: appTheme.black900,
            ),
            onPressed: onRightBtnPressed,
          ),
          if (showBadge && badgeCount > 0)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$badgeCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
