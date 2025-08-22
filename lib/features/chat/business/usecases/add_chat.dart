import 'package:clean_architutre_learn/features/chat/business/entities/chat_bubble.dart';
import 'package:clean_architutre_learn/features/chat/business/repo/chat_bubble_repository.dart';

class AddChat {
  final ChatBubbleRepository chatbublerepo;
  AddChat(this.chatbublerepo);
  Future<void> call(Chatbubble chat) {
    return chatbublerepo.addChat(chat);
  }
}
