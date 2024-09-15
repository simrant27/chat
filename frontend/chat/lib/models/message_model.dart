class MessageModel {
  String?
      type; // source or destination if type is source align in righside otherwise left side
  String? message;
  String? time;
  MessageModel({this.type, this.message, this.time});
}
