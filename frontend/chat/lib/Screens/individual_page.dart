import 'package:chat/CustomUi/own_msg.dart';
import 'package:chat/CustomUi/replycard.dart';
import 'package:chat/models/chat_model.dart';
import 'package:chat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualPage extends StatefulWidget {
  const IndividualPage(
      {super.key, required this.chatModel, required this.sourceChat});
  final ChatModel chatModel;
  final ChatModel sourceChat;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  late IO.Socket socket;
  bool sendButton = false;
  List<MessageModel>? messages = [];

  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io("http://192.168.18.121:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.sourceChat.id);
    socket.onConnect((data) {
      print("connected");
      socket.on("message", (msg) {
        print(msg);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
        setMessage("destination", msg["message"]);
      });
    });
    print(socket.connected);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    setState(() {
      messages!.add(messageModel);
    });
  }

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
            Text(widget.chatModel.name, style: TextStyle(fontSize: 18.5)),
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
        child: Column(
          children: [
            Expanded(
              // height: MediaQuery.of(context).size.height - 140,
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: messages!.length + 1,
                itemBuilder: (context, index) {
                  if (index == messages!.length) {
                    return Container(
                      height: 70,
                    );
                  }
                  if (messages![index].type == "source") {
                    return OwnMsgCard(
                      message: messages![index].message,
                      time: messages![index].time,
                    );
                  } else {
                    return Replycard(
                      message: messages![index].message,
                      time: messages![index].time,
                    );
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 70,
                      margin: EdgeInsets.only(left: 10, right: 2, bottom: 10),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        controller: _controller,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        onChanged: (value) {
                          if (value.length > 0) {
                            setState(() {
                              sendButton = true;
                            });
                          } else {
                            setState(() {
                              sendButton = false;
                            });
                          }
                        },
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CircleAvatar(
                        radius: 25,
                        child: IconButton(
                          icon: Icon(sendButton ? Icons.send : Icons.mic),
                          onPressed: () {
                            if (sendButton) {
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeOut);
                              sendMessage(_controller.text,
                                  widget.sourceChat.id!, widget.chatModel.id!);
                              _controller.clear();
                              setState(() {
                                sendButton = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
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
