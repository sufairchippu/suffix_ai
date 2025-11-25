class ChatSetModel {
  final String chatSetId;
  final String msg;
  ChatSetModel({required this.chatSetId, required this.msg});

  Map<String, dynamic> toJson() => {'chat_set_id': chatSetId, 'message': msg};
  factory ChatSetModel.fromJson(Map<String, dynamic> json) =>
      ChatSetModel(chatSetId: json['chat_set_id'], msg: json['message']);
}
