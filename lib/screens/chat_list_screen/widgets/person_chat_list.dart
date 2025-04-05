import 'package:amazmart/screens/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class PersonChatData {
  String? title;
  String? image;
  String? subtitle;
  bool? active;
  String? last;
  List<MessagesData>? messagesData;

  PersonChatData({
    this.title,
    this.subtitle,
    this.active,
    this.last,
    this.image,
    this.messagesData
  });
}

class MessagesData {
  String? type;
  String? id;
  String? text;
  String? author;
  String? status;
  String? createdAt;

 
  MessagesData({
    this.type,
    this.id,
    this.text,
    this.author,
    this.status,
    this.createdAt,
  });
}
  class Author {
    static const String RECEIVER_USER = 'RECEIVER_USER';
    static const String SENDER_USER = 'SENDER_USER';
  }
  class Status {
    static const String delivered = 'delivered';
    static const String sent = 'sent';
    static const String padding= 'padding';
  }
  class Type {
    static const String text = 'text';
    static const String image = 'image';
    static const String video= 'video';
  }






class PersonChatList extends StatelessWidget {
  PersonChatData? person;

  PersonChatList({super.key, this.person});

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(
          personChatData: person,
        ),
      )),
      child: Padding(
        padding: EdgeInsets.only(left: 14.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.h,
              width: 50.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomImageView(
                    imagePath: person?.image ?? ImageConstant.iconNotification,
                    height: 50.h,
                    width: 50.h,
                    radius: BorderRadius.circular(10.h),
                  ),
                  person!.active!
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 10.h,
                            width: 10.h,
                            decoration: BoxDecoration(
                              color: appTheme.green70001,
                              borderRadius: BorderRadius.circular(5.h),
                              border: Border.all(
                                color: appTheme.whiteA700,
                                width: 2.h,
                                strokeAlign: BorderSide.strokeAlignOutside,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            SizedBox(width: 8.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person!.title!,
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    person!.subtitle!,
                    style: CustomTextStyles.bodyMediumBluegray40014_1,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.h),
            Text(
              person!.last!,
              style: CustomTextStyles.bodyMediumBluegray40014,
            ),
          ],
        ),
      ),
    );
  }
}
