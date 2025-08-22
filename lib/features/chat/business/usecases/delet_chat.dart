import 'package:clean_architutre_learn/features/chat/business/repo/chat_bubble_repository.dart';

class DeletChat {
  final ChatBubbleRepository chatbubblerrepoo;
  DeletChat(this.chatbubblerrepoo);
  Future<void> call(int indexId) {
    return chatbubblerrepoo.deleteChat(indexId);
  }
}
