import 'package:amazmart/theme/custom_button_style.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class CategoriesButton extends StatefulWidget {
  final String label; // Text label for the item
  final VoidCallback onTap; // Callback for item click

  CategoriesButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  _CategoriesButtonState createState() => _CategoriesButtonState();
}

class _CategoriesButtonState extends State<CategoriesButton> {
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
        // width: 60.h,
        child: Column(
          children: [
            Container(
              height: 40.h,

              // padding: EdgeInsets.only(right: 2),
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    selecter = !selecter; // Toggle the selection state on tap
                  });
                  widget
                      .onTap(); // Call the onTap callback passed to the widget
                },
                child: Text(
                  widget.label,
                  style: CustomTextStyles.titleMediumErrorContainer.copyWith(fontSize: 13),
                ),
                style: selecter
                    ? CustomButtonStyles.outlinePrimary
                    : CustomButtonStyles.outlineIndigoTLS,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
