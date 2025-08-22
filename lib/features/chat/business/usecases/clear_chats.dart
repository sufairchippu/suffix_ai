import '../repo/chat_bubble_repository.dart';

class ClearChats  {
  final ChatBubbleRepository chatbublerepo;
  ClearChats(this.chatbublerepo);
  Future<void> call() {
    return chatbublerepo.clearChats();
  }
}