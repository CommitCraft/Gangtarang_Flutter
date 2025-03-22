import 'package:amazmart/screens/chat_list_screen/widgets/person_chat_list.dart';
import 'package:amazmart/screens/search_screen/search_screen.dart';
import 'package:amazmart/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          boxDecoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [appTheme.cyan200, appTheme.cyan50])),
          title: 'Messages',
          rightIconPath: ImageConstant.iconSearch,
          rightBtn: true,
          onRightBtnPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  SearchScreen(),
            ));
          },
        ),
        backgroundColor: appTheme.whiteA700,
        body: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListBody(
                        children: List.generate(
                          personList.length,
                          (index) {
                            var i = personList[index];
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: appTheme.blueGray50,
                                          width: 1))),
                              padding: EdgeInsets.fromLTRB(4, 8, 10, 10),
                              child: PersonChatList(
                                person: i,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

List<PersonChatData> personList = [
  PersonChatData(
      active: true,
      last: 'Fre',
      title: 'Sophia Martinez',
      subtitle: 'Haha, I hit you up',
      image: ImageConstant.ImgNoti1,
      messagesData: [
        MessagesData(
            author: Author.RECEIVER_USER,
            createdAt: '1696494723000',
            status: Status.delivered,
            text: 'Hello',
            type: Type.text),
        MessagesData(
            author: Author.SENDER_USER,
            createdAt: '1696494723000',
            status: Status.sent,
            text: 'Hi!',
            type: Type.text),
        MessagesData(
            author: Author.RECEIVER_USER,
            createdAt: '1696494724000',
            status: Status.delivered,
            text: 'How are you?',
            type: Type.text),
        MessagesData(
            author: Author.SENDER_USER,
            createdAt: '1696494725000',
            status: Status.sent,
            text: 'I\'m good, you?',
            type: Type.text),
        MessagesData(
            author: Author.RECEIVER_USER,
            createdAt: '1696494726000',
            status: Status.delivered,
            text: 'I\'m doing well!',
            type: Type.text),
        MessagesData(
            author: Author.SENDER_USER,
            createdAt: '1696494727000',
            status: Status.sent,
            text: 'That\'s awesome!',
            type: Type.text),
      ]
  ),
  PersonChatData(
    active: false,
    last: '2 hours ago',
    title: 'John Doe',
    subtitle: 'Just got back from a trip!',
    image: ImageConstant.ImgNoti2,
    messagesData: [
      MessagesData(
          author: Author.RECEIVER_USER,
          createdAt: '1696494723000',
          status: Status.delivered,
          text: 'Hey, how was the trip?',
          type: Type.text),
      MessagesData(
          author: Author.SENDER_USER,
          createdAt: '1696494724000',
          status: Status.sent,
          text: 'It was great, thanks for asking!',
          type: Type.text),
      MessagesData(
          author: Author.RECEIVER_USER,
          createdAt: '1696494725000',
          status: Status.delivered,
          text: 'What did you do?',
          type: Type.text),
      MessagesData(
          author: Author.SENDER_USER,
          createdAt: '1696494726000',
          status: Status.sent,
          text: 'Lots of hiking and exploring!',
          type: Type.text),
    ]
  ),
  PersonChatData(
    active: true,
    last: '5 mins ago',
    title: 'Jane Smith',
    subtitle: 'I’m on my way!',
    image: ImageConstant.ImgNoti3,
    messagesData: [
      MessagesData(
          author: Author.RECEIVER_USER,
          createdAt: '1696494723000',
          status: Status.delivered,
          text: 'How far are you?',
          type: Type.text),
      MessagesData(
          author: Author.SENDER_USER,
          createdAt: '1696494724000',
          status: Status.sent,
          text: 'I\'m close, just a few more minutes.',
          type: Type.text),
      MessagesData(
          author: Author.RECEIVER_USER,
          createdAt: '1696494725000',
          status: Status.delivered,
          text: 'Can\'t wait!',
          type: Type.text),
    ]
  ),
  PersonChatData(
    active: false,
    last: 'Yesterday',
    title: 'Samuel Johnson',
    subtitle: 'Let’s catch up soon!',
    image: ImageConstant.ImgNoti4,
    messagesData: [
      MessagesData(
          author: Author.RECEIVER_USER,
          createdAt: '1696494723000',
          status: Status.delivered,
          text: 'Hey, when are you free?',
          type: Type.text),
      MessagesData(
          author: Author.SENDER_USER,
          createdAt: '1696494724000',
          status: Status.sent,
          text: 'How about this weekend?',
          type: Type.text),
      MessagesData(
          author: Author.RECEIVER_USER,
          createdAt: '1696494725000',
          status: Status.delivered,
          text: 'Sounds good!',
          type: Type.text),
    ]
  ),
  PersonChatData(
    active: true,
    last: '10:30 AM',
    title: 'Emily Clark',
    subtitle: 'Got your message!',
    image: ImageConstant.ImgNoti5,
    messagesData: [
      MessagesData(
          author: Author.RECEIVER_USER,
          createdAt: '1696494723000',
          status: Status.delivered,
          text: 'Hey Emily, what’s up?',
          type: Type.text),
      MessagesData(
          author: Author.SENDER_USER,
          createdAt: '1696494724000',
          status: Status.sent,
          text: 'Just wanted to check in!',
          type: Type.text),
      MessagesData(
          author: Author.RECEIVER_USER,
          createdAt: '1696494725000',
          status: Status.delivered,
          text: 'All good here!',
          type: Type.text),
      MessagesData(
          author: Author.SENDER_USER,
          createdAt: '1696494726000',
          status: Status.sent,
          text: 'Awesome, let’s chat later.',
          type: Type.text),
    ]
  ),
  PersonChatData(
    active: false,
    last: '11:45 PM',
    title: 'Michael Brown',
    subtitle: 'I’ll call you later',
    image: ImageConstant.ImgNoti6,
    messagesData: [
      MessagesData(
          author: Author.RECEIVER_USER,
          createdAt: '1696494723000',
          status: Status.delivered,
          text: 'Hey, call me when you can.',
          type: Type.text),
      MessagesData(
          author: Author.SENDER_USER,
          createdAt: '1696494724000',
          status: Status.sent,
          text: 'Sure thing!',
          type: Type.text),
    ]
  ),
  PersonChatData(
    active: true,
    last: 'Today',
    title: 'Olivia Taylor',
    subtitle: 'Let’s grab coffee!',
    image: ImageConstant.ImgNoti2,
    messagesData: [
      MessagesData(
          author: Author.RECEIVER_USER,
          createdAt: '1696494723000',
          status: Status.delivered,
          text: 'What time works for you?',
          type: Type.text),
      MessagesData(
          author: Author.SENDER_USER,
          createdAt: '1696494724000',
          status: Status.sent,
          text: 'How about 3 PM?',
          type: Type.text),
      MessagesData(
          author: Author.RECEIVER_USER,
          createdAt: '1696494725000',
          status: Status.delivered,
          text: 'Perfect, see you then!',
          type: Type.text),
    ]
  ),
  PersonChatData(
    active: true,
    last: '15 mins ago',
    title: 'Lucas White',
    subtitle: 'I’m almost there!',
    image: ImageConstant.ImgNoti4,
    messagesData: [
      MessagesData(
          author: Author.RECEIVER_USER,
          createdAt: '1696494723000',
          status: Status.delivered,
          text: 'Are you close?',
          type: Type.text),
      MessagesData(
          author: Author.SENDER_USER,
          createdAt: '1696494724000',
          status: Status.sent,
          text: 'Just a couple of blocks away.',
          type: Type.text),
    ]
  ),
  PersonChatData(
    active: false,
    last: 'Earlier today',
    title: 'Sophia Lee',
    subtitle: 'Talk to you soon!',
    image: ImageConstant.ImgNoti5,
    messagesData: [
      MessagesData(
          author: Author.RECEIVER_USER,
          createdAt: '1696494723000',
          status: Status.delivered,
          text: 'How was your day?',
          type: Type.text),
      MessagesData(
          author: Author.SENDER_USER,
          createdAt: '1696494724000',
          status: Status.sent,
          text: 'It was pretty good!',
          type: Type.text),
    ]
  ),
  PersonChatData(
    active: true,
    last: 'Just now',
    title: 'David Miller',
    subtitle: 'Sending the file now',
    image: ImageConstant.ImgNoti2,
    messagesData: [
      MessagesData(
          author: Author.RECEIVER_USER,
          createdAt: '1696494723000',
          status: Status.delivered,
          text: 'Did you send it?',
          type: Type.text),
      MessagesData(
          author: Author.SENDER_USER,
          createdAt: '1696494724000',
          status: Status.sent,
          text: 'Just did!',
          type: Type.text),
      MessagesData(
          author: Author.RECEIVER_USER,
          createdAt: '1696494725000',
          status: Status.delivered,
          text: 'Got it, thanks!',
          type: Type.text),
    ]
  ),
];



  // List<PersonChatData> personList = [
  //   PersonChatData(
  //       active: true,
  //       last: 'Fre',
  //       title: 'Sophia Martinez',
  //       subtitle: 'Haha, I hit you up',
  //       image: ImageConstant.spo1,
  //       messagesData: [
  //         MessagesData(
  //             author: Author.RECEIVER_USER,
  //             createdAt: '1696494723000',
  //             status: Status.delivered,
  //             text: 'Hello',
  //             type: Type.text),
  //         MessagesData(
  //             author: Author.SENDER_USER,
  //             createdAt: '1696494723000',
  //             status: Status.sent,
  //             text: 'Hi!',
  //             type: Type.text),
  //       ]),
  //   PersonChatData(
  //     active: false,
  //     last: '2 hours ago',
  //     title: 'John Doe',
  //     subtitle: 'Just got back from a trip!',
  //     image: ImageConstant.spo2,
  //   ),
  //   PersonChatData(
  //     active: true,
  //     last: '5 mins ago',
  //     title: 'Jane Smith',
  //     subtitle: 'I’m on my way!',
  //     image: ImageConstant.spo1,
  //   ),
  //   PersonChatData(
  //     active: false,
  //     last: 'Yesterday',
  //     title: 'Samuel Johnson',
  //     subtitle: 'Let’s catch up soon!',
  //     image: ImageConstant.spo1,
  //   ),
  //   PersonChatData(
  //     active: true,
  //     last: '10:30 AM',
  //     title: 'Emily Clark',
  //     subtitle: 'Got your message!',
  //     image: ImageConstant.spo1,
  //   ),
  //   PersonChatData(
  //     active: false,
  //     last: '11:45 PM',
  //     title: 'Michael Brown',
  //     subtitle: 'I’ll call you later',
  //     image: ImageConstant.spo2,
  //   ),
  //   PersonChatData(
  //     active: true,
  //     last: 'Today',
  //     title: 'Olivia Taylor',
  //     subtitle: 'Let’s grab coffee!',
  //     image: ImageConstant.spo1,
  //   ),
  //   PersonChatData(
  //     active: true,
  //     last: '15 mins ago',
  //     title: 'Lucas White',
  //     subtitle: 'I’m almost there!',
  //     image: ImageConstant.spo1,
  //   ),
  //   PersonChatData(
  //     active: false,
  //     last: 'Earlier today',
  //     title: 'Sophia Lee',
  //     subtitle: 'Talk to you soon!',
  //     image: ImageConstant.spo1,
  //   ),
  //   PersonChatData(
  //     active: true,
  //     last: 'Just now',
  //     title: 'David Miller',
  //     subtitle: 'Sending the file now',
  //     image: ImageConstant.spo2,
  //   ),
  // ];

  // List<PersonChatList> personList = [
  //   PersonChatList(
  //     person: PersonChatData(
  //       active: true,
  //       last: 'Fre',
  //       title: 'Sophia Martinez',
  //       subtitle: 'Haha, I hit you up',
  //       image: ImageConstant.spo1,
  //     ),
  //   ),
  //   PersonChatList(
  //     person: PersonChatData(
  //       active: false,
  //       last: '2 hours ago',
  //       title: 'John Doe',
  //       subtitle: 'Just got back from a trip!',
  //       image: ImageConstant.spo2,
  //     ),
  //   ),
  //   PersonChatList(
  //     person: PersonChatData(
  //       active: true,
  //       last: '5 mins ago',
  //       title: 'Jane Smith',
  //       subtitle: 'I’m on my way!',
  //       image: ImageConstant.spo1,
  //     ),
  //   ),
  //   PersonChatList(
  //     person: PersonChatData(
  //       active: false,
  //       last: 'Yesterday',
  //       title: 'Samuel Johnson',
  //       subtitle: 'Let’s catch up soon!',
  //       image: ImageConstant.spo1,
  //     ),
  //   ),
  //   PersonChatList(
  //     person: PersonChatData(
  //       active: true,
  //       last: '10:30 AM',
  //       title: 'Emily Clark',
  //       subtitle: 'Got your message!',
  //       image: ImageConstant.spo1,
  //     ),
  //   ),
  //   PersonChatList(
  //     person: PersonChatData(
  //       active: false,
  //       last: '11:45 PM',
  //       title: 'Michael Brown',
  //       subtitle: 'I’ll call you later',
  //       image: ImageConstant.spo2,
  //     ),
  //   ),
  //   PersonChatList(
  //     person: PersonChatData(
  //       active: true,
  //       last: 'Today',
  //       title: 'Olivia Taylor',
  //       subtitle: 'Let’s grab coffee!',
  //       image: ImageConstant.spo1,
  //     ),
  //   ),
  //   PersonChatList(
  //     person: PersonChatData(
  //       active: true,
  //       last: '15 mins ago',
  //       title: 'Lucas White',
  //       subtitle: 'I’m almost there!',
  //       image: ImageConstant.spo1,
  //     ),
  //   ),
  //   PersonChatList(
  //     person: PersonChatData(
  //       active: false,
  //       last: 'Earlier today',
  //       title: 'Sophia Lee',
  //       subtitle: 'Talk to you soon!',
  //       image: ImageConstant.spo1,
  //     ),
  //   ),
  //   PersonChatList(
  //     person: PersonChatData(
  //       active: true,
  //       last: 'Just now',
  //       title: 'David Miller',
  //       subtitle: 'Sending the file now',
  //       image: ImageConstant.spo2,
  //     ),
  //   ),
  // ];
}
