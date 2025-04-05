import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class TextWithIcon extends StatelessWidget {
  final String text;
  final String? icon; // Icon is optional
  final TextStyle? textStyle;
  final Color? iconColor;

  const TextWithIcon({
    Key? key,
    required this.text,
    this.icon,
    this.textStyle,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
      decoration: BoxDecoration(
        color: appTheme.blueGray50,
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Shrink to fit content
        children: [
          if (icon != null) // Display icon only if it's provided
            CustomImageView(
             imagePath: icon.toString(),
              color: iconColor ?? const Color.fromARGB(255, 70, 181, 155),
              height: 20,width: 20,
              // size: 20,
            ),
          if (icon != null) SizedBox(width: 8), // Space between icon and text
          Text(
            text,
            style: CustomTextStyles.labelLargeOnPrimary13.copyWith(fontWeight: FontWeight.w300),
          ),
          
        ],
      ),
    );
  }
}
