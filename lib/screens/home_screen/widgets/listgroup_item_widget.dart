import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class ListSponsoredItemWidget extends StatelessWidget {
  final String imagePath;
  const ListSponsoredItemWidget({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170.h,
      child: CustomImageView(
        imagePath: imagePath,
        height: 112.h,
        width: 170.h,
      ),
    );
  }
}
