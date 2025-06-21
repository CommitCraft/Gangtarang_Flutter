import 'package:amazmart/theme/custom_button_style.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class CatButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const CatButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  _CatButtonState createState() => _CatButtonState();
}

class _CatButtonState extends State<CatButton> {
  bool selecter = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        child: Column(
          children: [
            Container(
              height: 40.h,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    selecter = !selecter;
                  });
                  widget.onTap();
                },
                style: CustomButtonStyles.outlineIndigoTLS.copyWith(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.label,
                    style: CustomTextStyles.titleSmallErrorContainer.copyWith(
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
