enum MessegeOwner { user, ai, erorr }

class Chatbubble {
  String message;
  String time;
  String? id;
  MessegeOwner msgtype;
  List<String>? attachment;
  Chatbubble({
    required this.message,
    required this.time,
     this.id,
    required this.msgtype,
    this.attachment,
  });
}
