import 'package:amazmart/core/utils/function.dart';
import 'package:amazmart/screens/chat_list_screen/widgets/person_chat_list.dart';
import 'package:amazmart/screens/chat_screen/widgets/chat.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:amazmart/widgets/custom_input.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class ChatScreen extends StatefulWidget {
  PersonChatData? personChatData;
  ChatScreen({super.key, this.personChatData});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textFiled = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textFiled = TextEditingController();
  }

  void sentMsg() {

     DateTime now = DateTime.now();
  int timestamp = now.millisecondsSinceEpoch;
    setState(() {
    widget.personChatData!.messagesData!
        .add(MessagesData(author: Author.SENDER_USER,  text: _textFiled.text,createdAt: '$timestamp'));

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: double.infinity,
          leading: Container(
            height: 60,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white, // Replace with your app's theme color
            ),
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
                        onPressed: () => Navigator.pop(context),
                      ),
                      CustomImageView(
                        imagePath: widget.personChatData!.image!,
                        margin: EdgeInsets.fromLTRB(0, 7, 0, 7),
                      ),
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.personChatData!.title!,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                widget.personChatData!.active!
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 10,
                                            width: 10,
                                            margin: EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(
                                                color: appTheme.greenA700,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))),
                                          ),
                                          Text(
                                            'Online',
                                            style: CustomTextStyles
                                                .bodyMediumErrorContainer,
                                          )
                                        ],
                                      )
                                    : Container()
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          ToastMessage.show(
                              context, 'Call Action Button Click');
                        },
                        child: CustomImageView(
                          imagePath: ImageConstant.IconCall,
                          margin: EdgeInsets.only(right: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: appTheme.blueGray50,
        body: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ListBody(
                        children: List.generate(
                          widget.personChatData!.messagesData!.length,
                          (index) {
                            var messagesData =
                                widget.personChatData!.messagesData![index];
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: appTheme.blueGray50,
                                          width: 1))),
                              padding: EdgeInsets.fromLTRB(4, 8, 10, 10),
                              child: Chat(
                                messagesData: messagesData,
                                imagePath: widget.personChatData!.image!,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                color: appTheme.whiteA700,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    CustomImageView(imagePath: ImageConstant.Iconsmile),
                    CustomInputField(
                      controller: _textFiled,
                      width: MediaQuery.of(context).size.width - 110,
                      hintText: 'Type Something',
                      borderDecoration: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.h),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                    ),
                    GestureDetector(
                      onTap: sentMsg,
                      child: CustomImageView(imagePath: ImageConstant.IconSent),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
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
}
