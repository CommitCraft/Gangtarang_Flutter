import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class HomedecorListItemWidget extends StatelessWidget {
  final String img;
  final VoidCallback? ontap;
  const HomedecorListItemWidget({Key? key, required this.img , this.ontap}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return 
   GestureDetector( onTap: ontap, child:  SizedBox(
      width: 110,
      height: 170,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 140,
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
            borderRadius: BorderRadiusStyle.roundedBorder6,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: img,
                height: 170,
                width: 110,
              ),
            ],
          ),
        ),
      ),
    )
  ,);
  }
}
