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
