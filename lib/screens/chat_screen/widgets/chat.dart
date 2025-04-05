import 'package:amazmart/core/app_export.dart';
import 'package:amazmart/screens/chat_list_screen/widgets/person_chat_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chat extends StatelessWidget {
  MessagesData? messagesData;
  String? imagePath;
  Chat({super.key, this.messagesData, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return messagesData!.author == Author.RECEIVER_USER
        ? Container(
           width: messagesData!.text!.length >= 35 ? MediaQuery.of(context).size.width - 100 : null ,
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: imagePath!,
                  height: 40,
                  width: 40,
                  radius: BorderRadius.circular(50),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(right: 10, left: 10),
                      decoration: BoxDecoration(
                          color: appTheme.black900,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.zero)),
                      child: Text(
                        messagesData!.text!,
                        style: CustomTextStyles.bodyMediumWhiteA700,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        textAlign: TextAlign.left,
                        formatTimestamp(int.parse(messagesData!.createdAt!)),
                        style: CustomTextStyles.bodySmallOnPrimary,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    // height: 40,
                    width: messagesData!.text!.length >= 35 ? MediaQuery.of(context).size.width - 100 : null  ,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 10, left: 10 ,top: 12,bottom: 12),
                    decoration: BoxDecoration(
                        color: appTheme.whiteA700,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.zero,
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12))),
                    child: Text(
                      messagesData!.text!,
                      style: CustomTextStyles.bodyMediumErrorContainer,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      textAlign: TextAlign.left,
                      formatTimestamp(int.parse(messagesData!.createdAt!)),
                      style: CustomTextStyles.bodySmallOnPrimary,
                    ),
                  ),
                ],
              ),
            ],
          );
  }

  String formatTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('hh:mm a').format(dateTime);
  }
}
