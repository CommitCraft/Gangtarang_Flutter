import 'package:amazmart/theme/custom_button_style.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class CatButton extends StatefulWidget {
  final String label; // Text label for the item
  final VoidCallback onTap; // Callback for item click

  CatButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  _CatButtonState createState() => _CatButtonState();
}

class _CatButtonState extends State<CatButton> {
  bool selecter = false; // Track selection state

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                  style: CustomTextStyles.titleSmallErrorContainer.copyWith(color: Colors.black ),
                ),
                style:  CustomButtonStyles.outlineIndigoTLS.copyWith(backgroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
