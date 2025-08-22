import 'package:clean_architutre_learn/features/chat/business/entities/chat_bubble.dart';
import 'package:clean_architutre_learn/features/chat/business/repo/chat_bubble_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetChats {
  final ChatBubbleRepository chatBubbleRepo;
  GetChats(this.chatBubbleRepo);
  Future<Either<Failure, List<Chatbubble>>> call() {
    return chatBubbleRepo.getChats();
  }
}
