import 'package:chat/CustomUi/custom_card.dart';
import 'package:chat/models/chat_model.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
        name: "Asmita",
        icon: Icons.group,
        isGroup: false,
        time: "18.05",
        currentMessage: "hello there"),
    ChatModel(
        name: "Oshin",
        icon: Icons.group,
        isGroup: false,
        time: "18.05",
        currentMessage: "hello hii"),
    ChatModel(
        name: "class5",
        icon: Icons.group,
        isGroup: true,
        time: "18.05",
        currentMessage: "hello there"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: chats[index],
        ),
      ),
    );
  }
}
