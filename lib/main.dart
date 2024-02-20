import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  ChatMessage({required this.messageContent, required this.messageType});
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
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
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
    double deviceHeight = MediaQuery.of(context).size.height;

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
          actions: const [Icon(Icons.menu, color: Color(0xffFCFCFC))]),
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
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (messages[index].messageType == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: messages[index].messageType == "receiver"
                              ? const Color(0xff1A1A1A)
                              : null,
                          gradient: messages[index].messageType == "sender"
                              ? const LinearGradient(colors: [
                                  Color(0xffFF006B),
                                  Color(0xffFF4593)
                                ])
                              : null,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          messages[index].messageContent,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ),
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
                                color: const Color(0xff3A3A3A),
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

                    onTap: () {
                      // scrollController
                      //     .jumpTo(scrollController.position.maxScrollExtent);

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
