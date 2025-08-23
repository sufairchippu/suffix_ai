// import 'package:clean_architutre_learn/features/chat/data/data_sources/ai_data_source.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// f
// final aiDataSourceProvider= Provider<AiDataSource>((ref) {

//   return AiDataSource();
// },);

import 'package:clean_architutre_learn/core/service/network/dio_provider.dart';
import 'package:clean_architutre_learn/core/utils/extenstion.dart';
import 'package:clean_architutre_learn/features/chat/business/usecases/get_message.dart';
import 'package:clean_architutre_learn/features/chat/data/data_sources/ai_data_source.dart';
import 'package:clean_architutre_learn/features/chat/data/model/ai_response_model.dart';
import 'package:clean_architutre_learn/features/chat/data/repo/ai_response_repo_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../business/entities/chat_bubble.dart';
import '../../business/repo/ai_responce_repository.dart';
import '../../data/model/chat_bubble_model.dart';
import 'chat_provider.dart';

// class AiMessgeNotifier extends StateNotifier<Content> {
//   AiMessgeNotifier(this._messge) : super(Content());
//   final GetMessage _messge;

//   Future<void> getAiReply(String input) async {
//   final reply=  await _messge(input);
// reply.fold(
//   (failure) {
//     // Handle error
//     print('Error: ${failure.message}');
//   },
//   (content) {
//     // If content has a list of messages
//     for (var message in content.parts!) {
//       ref
//                               .read(chatListNotifierProvider.notifier)
//                               .addchats(chat)
//       print(message);

//     }
//   },
// );
//   }
// }

class AiMessgeNotifier extends StateNotifier<Content> {
  AiMessgeNotifier(this.ref, this._messge) : super(Content());

  final Ref ref;
  final GetMessage _messge;

  Future<void> getAiReply(String input) async {
    final reply = await _messge(input);

    reply.fold(
      (failure) {
        print('Error: ${failure.message}');
      },
      (content) {
        // Update StateNotifier state with new content
        state = content;

        if (content.parts != null && content.parts!.isNotEmpty) {
          for (var message in content.parts!) {
            // Create your chat model
            final chat = Chatbubble(
              message: message.toString(),
              time: DateTime.now().toFormattedString(),
              // id: UniqueKey().hashCode, // or use any ID generator
              msgtype: MessegeOwner.ai,
              // Enum for AI messages
            );

            // Add to chat list via another provider
            // ref.read(chatListNotifierProvider.notifier).addchats(chat);

            print('AI Reply: $message');
          }
        }
      },
    );
  }
}

final aiMessgeNotifierProvider =
    StateNotifierProvider<AiMessgeNotifier, Content>((ref) {
      final getMesge = ref.read(getmessageProvider);
      return AiMessgeNotifier(ref, getMesge);
    });

final getmessageProvider = Provider<GetMessage>((ref) {
  final repo = ref.read(aireposProvider);
  return GetMessage(repo);
});

final aireposProvider = Provider<AiResponceRepository>((ref) {
  final aidata = ref.read(aiDataSourceProvider);
  return AiResponseRepoImpl(aidata);
});

final aiDataSourceProvider = Provider<AiDataSource>((ref) {
  final dio = ref.read(dioProvider);
  final client = DioClient(dio);
  return AiDataSource(client);
});
