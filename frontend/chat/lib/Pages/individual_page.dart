import 'package:chat/models/chat_model.dart';
import 'package:flutter/material.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        leadingWidth: 100,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.arrow_back,
                size: 24,
              ),
              CircleAvatar(
                child: widget.chatModel.isGroup!
                    ? Icon(Icons.group)
                    : Icon(Icons.person),
                radius: 25,
              ),
            ],
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.chatModel.name!, style: TextStyle(fontSize: 18.5)),
            Text(
              "Last seen at 18:06",
              style: TextStyle(fontSize: 13),
            )
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ListView(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 25,
                      margin: EdgeInsets.only(left: 10, right: 2, bottom: 10),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                            hintText: "Type a message",
                            border: InputBorder.none,
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (builder) => bottomsheet());
                                    },
                                    icon: Icon(Icons.attach_file)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.camera_alt)),
                              ],
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CircleAvatar(
                      radius: 25,
                      child: IconButton(
                        icon: Icon(Icons.mic),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              iconcreation(Icons.insert_drive_file, Colors.indigo, "Document"),
              iconcreation(Icons.camera_alt, Colors.pink, "Camera"),
              iconcreation(Icons.insert_photo, Colors.purple, "Gallery"),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconcreation(IconData icon, Color color, String text) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(
            color: Colors.white,
            icon,
            size: 29,
          ),
        ),
        Text(text),
      ],
    );
  }
}
