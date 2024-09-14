import 'package:chat/CustomUi/Contact_card.dart';
import 'package:chat/CustomUi/button_card.dart';
import 'package:chat/models/chat_model.dart';
import 'package:flutter/material.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      ChatModel(
        name: "Simran",
      ),
      ChatModel(
        name: "hari",
      ),
      ChatModel(
        name: "lala",
      ),
      ChatModel(
        name: "Asmi",
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Text("Select contact"),
      ),
      body: ListView.builder(
          itemCount: contacts.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ButtonCard();
            }
            return ContactCard(
              contact: contacts[index - 1],
            );
          }),
    );
  }
}
