import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'testvalley',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class ChatMessage {
  String messageContent;
  String messageType;
  String? username;
  String? image;
  String? time;
  int ringColor;
  bool active;
  ChatMessage(
      {required this.messageContent,
      required this.messageType,
      this.username,
      this.image,
      this.time,
      this.active = false,
      this.ringColor = 0xff0E0D0D});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scrollController = ScrollController();
  final TextEditingController textMessage = TextEditingController();

  final focusNode = FocusNode();
  List<ChatMessage> messages = [
    ChatMessage(
      messageContent: "오늘 저녁 식사 같이 하실 여성분? 제가 삽니다",
      messageType: "receiver",
      username: "목이길어슬픈기린",
      time: "3분 전",
      image: "assets/img1.png",
      active: true,
    ),
    ChatMessage(
      messageContent: "저 형 또 시작이네",
      messageType: "receiver",
      username: "일림안놓고는못살음",
      time: "3분 전",
      image: "assets/img3.png",
      ringColor: 0xff2B53E1,
    ),
    ChatMessage(messageContent: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ", messageType: "sender"),
    ChatMessage(
      messageContent: "너 T발 C야?",
      messageType: "receiver",
      username: "목이길어슬픈기린",
      time: "2분 전",
      image: "assets/img1.png",
      active: true,
    ),
    ChatMessage(
      messageContent: "근데 다 강남 사시는 거에요?",
      messageType: "receiver",
      username: "유령랜덤닉",
      time: "1분 전",
      image: "assets/img3.png",
      ringColor: 0xffFF006A,
    ),
    ChatMessage(
      messageContent: "아뇨 직장이 강남이에요",
      messageType: "receiver",
      username: "장난하지말고",
      time: "1분 전",
      image: "assets/img3.png",
      ringColor: 0xff2B53E1,
    ),
    ChatMessage(
      messageContent: "쿠팡 로켓 써보세요!",
      messageType: "receiver",
      username: "쿠팡",
      time: "1분 전",
      image: "assets/img2.png",
    ),
    ChatMessage(messageContent: "쿠팡이 또 ...", messageType: "sender"),
    ChatMessage(
      messageContent: "썸 좀 보내주세요 다이아님들",
      messageType: "receiver",
      username: "썸보내줘",
      time: "1분 전",
      image: "assets/img3.png",
      ringColor: 0xff2B53E1,
    ),
  ];
  @override
  void initState() {
    super.initState();
  }

  Future<void> onFieldSubmitted() async {
    setState(() {
      messages.add(ChatMessage(
          messageContent: textMessage.text.trim(), messageType: "sender"));
    });

    // Move the scroll position to the bottom
    Timer(
        const Duration(milliseconds: 500),
        () =>
            scrollController.jumpTo(scrollController.position.maxScrollExtent));

    textMessage.clear();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    // double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff0E0D0D),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          backgroundColor: const Color(0xff0E0D0D),
          leading: IconButton(
            onPressed: () {
              // Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xffFCFCFC)),
          ),
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "강남스팟",
            style: TextStyle(color: Color(0xffFCFCFC), fontSize: 16),
          ),
          actions: const [Icon(Icons.menu, color: Color(0xffF5F5F5))]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                focusNode.unfocus(); // <-- Hide virtual keyboard
              },
              child: ListView.builder(
                controller: scrollController,
                itemCount: messages.length,
                shrinkWrap: true,
                // reverse: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var message = messages[index];
                  return Container(
                    width: deviceWidth,
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment:
                          messages[index].messageType == "receiver"
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        messages[index].messageType == "receiver"
                            ? Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0.0, 0, 10, 0),
                                child: CircleAvatar(
                                  backgroundColor: Color(message.ringColor),
                                  radius: 17,
                                  child: CircleAvatar(
                                    radius: 16,
                                    // backgroundColor: Colors.transparent,
                                    backgroundColor: Colors.black,
                                    child: messages[index].image != null
                                        ? Image.asset(
                                            messages[index].image ?? "",
                                            fit: BoxFit.fill,
                                          )
                                        : const Icon(Icons.person, size: 20),

                                    // child: Icon(Icons.person, size: 18),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              constraints:
                                  BoxConstraints(maxWidth: deviceWidth * 0.7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft:
                                      messages[index].messageType == "sender"
                                          ? const Radius.circular(16)
                                          : const Radius.circular(4),
                                  topRight:
                                      messages[index].messageType == "sender"
                                          ? const Radius.circular(4)
                                          : const Radius.circular(16),
                                  bottomLeft: const Radius.circular(18),
                                  bottomRight: const Radius.circular(18),
                                ),
                                color: messages[index].messageType == "receiver"
                                    ? const Color(0xff1A1A1A)
                                    : null,
                                gradient:
                                    messages[index].messageType == "sender"
                                        ? const LinearGradient(colors: [
                                            Color(0xffFF006B),
                                            Color(0xffFF4593)
                                          ])
                                        : null,
                              ),
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  messages[index].username != null
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              messages[index].username ?? "",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff666666)),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Badge(
                                              largeSize: 7,
                                              smallSize: 7,
                                              backgroundColor: message.active
                                                  ? Colors.teal
                                                  : Colors.transparent,
                                              child: null,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                  Text(
                                    messages[index].messageContent,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            messages[index].messageType == "receiver"
                                ? Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                                    child: Text(
                                      messages[index].time ?? "",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff666666)),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            child: Row(
              children: [
                const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.add,
                    color: Color(0xffF5F5F5),
                  ),
                ),
                SizedBox(
                  width: deviceWidth * 0.85,
                  child: TextFormField(
                    controller: textMessage,
                    focusNode: focusNode,
                    // initialValue: "안녕하세요",
                    enableSuggestions: false,
                    autocorrect: false,
                    style: const TextStyle(
                      color: Color(0xffFCFCFC),
                      fontSize: 14,
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: '메세지 보내기',
                      hintStyle: const TextStyle(
                        color: Color(0xff666666),
                      ),
                      // border: OutlineInputBorder(
                      //   borderSide: const BorderSide(
                      //     color: Color(0xff323232),
                      //   ),
                      //   borderRadius: BorderRadius.circular(50.0),
                      // ),
                      filled: true,
                      fillColor: const Color(0xff1A1A1A),
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: onFieldSubmitted,
                          child: Container(
                            decoration: BoxDecoration(
                                color: textMessage.text.isNotEmpty
                                    ? const Color(0xffFF006B)
                                    : const Color(0xff3A3A3A),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Icon(
                              Icons.arrow_upward,
                              color: Color(0xff1A1A1A),
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xff323232),
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xff323232),
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      // focusedErrorBorder: OutlineInputBorder(
                      //   borderSide: const BorderSide(
                      //       color: Color.fromARGB(0, 36, 10, 10)),
                      //   borderRadius: BorderRadius.circular(15.0),
                      // ),
                      // errorBorder: OutlineInputBorder(
                      //   borderSide: const BorderSide(color: Colors.transparent),
                      //   borderRadius: BorderRadius.circular(15.0),
                      // ),
                    ),
                    onTapOutside: (event) {
                      // FocusScopeNode currentFocus = FocusScope.of(context);

                      // if (!currentFocus.hasPrimaryFocus) {
                      //   currentFocus.unfocus();
                      // }
                    },
                    onChanged: (v) {
                      setState(() {});
                    },
                    onTap: () {
                      Timer(
                          const Duration(milliseconds: 500),
                          () => scrollController.jumpTo(
                              scrollController.position.maxScrollExtent));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
