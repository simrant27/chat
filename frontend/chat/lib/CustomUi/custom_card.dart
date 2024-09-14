import 'package:chat/Screens/individual_page.dart';
import 'package:chat/models/chat_model.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.chatModel});
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualPage(
                      chatModel: chatModel,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child:
                  chatModel.isGroup! ? Icon(Icons.group) : Icon(Icons.person),
              radius: 25,
            ),
            title: Text(
              chatModel.name!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              chatModel.currentMessage!,
              style: TextStyle(fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(chatModel.time!),
          ),
          Divider()
        ],
      ),
    );
  }
}
