enum MessegeOwner { user, ai, erorr }

class Chatbubble {
  String message;
  String time;
  int? id;
  MessegeOwner msgtype;
  String chatSetID;
  List<Attachment>? attachment;

  Chatbubble({
    required this.chatSetID,
    required this.message,
    required this.time,
    this.id,
    required this.msgtype,
    this.attachment,
  });

  // Convert Dart object to JSON (for Supabase insert)
  Map<String, dynamic> toJson() => {
    "id": id,
    "chat_set_id": chatSetID,
    "message": message,
    "time": time,
    "msgtype": msgtype.name, // enum → string
    "attachments": attachment?.map((a) => a.toMap()).toList(),
  };

  // Convert JSON from database to Dart model
  factory Chatbubble.fromJson(Map<String, dynamic> json) => Chatbubble(
    id: json["id"],
    chatSetID: json["chat_set_id"],
    message: json["message"] ?? "",
    time: json["time"] ?? "",
    msgtype: MessegeOwner.values.firstWhere(
      (element) => element.name == json["msgtype"],
      orElse: () => MessegeOwner.user,
    ),
    attachment: json["attachments"] != null
        ? (json["attachments"] as List)
              .map((a) => Attachment.fromMap(a))
              .toList()
        : [],
  );
}

class Attachment {
  final String path; // local path or Supabase URL
  final String type; // image/jpeg, application/pdf, etc.
  final String? name;
  final String? supabaseUrl;

  Attachment({
    required this.path,
    required this.type,
    this.name,
    this.supabaseUrl,
  });

  Map<String, dynamic> toMap() => {
    'path': path,
    'type': type,
    'name': name,
    'supabaseUrl': supabaseUrl,
  };

  factory Attachment.fromMap(Map<String, dynamic> map) => Attachment(
    path: map['path'],
    type: map['type'],
    name: map['name'],
    supabaseUrl: map['supabaseUrl'],
  );
}
