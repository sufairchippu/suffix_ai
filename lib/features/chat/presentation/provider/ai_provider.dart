import 'dart:io';

import 'package:clean_architutre_learn/core/service/local_storage/local_keys.dart';
import 'package:clean_architutre_learn/core/service/local_storage/local_storage_service.dart';
import 'package:clean_architutre_learn/core/service/network/dio/dio_client_methods.dart';
import 'package:clean_architutre_learn/core/service/network/dio/gemini_provider.dart';
import 'package:clean_architutre_learn/core/utils/extenstion.dart';

import 'package:clean_architutre_learn/features/chat/business/usecases/get_message.dart';
import 'package:clean_architutre_learn/features/chat/data/data_sources/ai_data_source.dart';
import 'package:clean_architutre_learn/features/chat/data/model/ai_response_model.dart';
import 'package:clean_architutre_learn/features/chat/data/repo/ai_response_repo_impl.dart';
import 'package:clean_architutre_learn/features/chat/presentation/provider/supabase_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../business/entities/chat_bubble.dart';
import '../../business/repo/ai_responce_repository.dart';
import 'chat_provider.dart';

class AiMessgeNotifier extends StateNotifier<Content> {
  AiMessgeNotifier(this.ref, this._messge) : super(Content());

  final Ref ref;
  final GetMessage _messge;

  Future<void> getAiReply({
    required String data,
    List<File>? files,

  }) async {
    // ref.read(chatListNotifierProvider.notifier).loadChats();

    ref.read(loadingmsgProvider.notifier).state = true;
    final reply = await _messge(
      data: data,
      files: files,

    );

    reply.fold(
      (failure) {
        debugPrint('Error: ${failure.message}');
      },
      (content) async {
        // Update StateNotifier state with new content

        state = content;

        if (content.parts != null && content.parts!.isNotEmpty) {
          for (var message in content.parts!) {
            // Create your chat model
            final chat = Chatbubble(
              message: message.text.toString(),
              time: DateTime.now().toFormattedString(),
              // id: UniqueKey().hashCode, // or use any ID generator
              msgtype: MessegeOwner.ai,
              chatSetID: LocalStorageService.getString(
                LocalServiceKeys.CHAT_SET_ID,
              ),
              //Uiutils.generateUniqueId(),
              // Enum for AI messages
            );

            // Add to chat list via another provider
            await ref
                .read(chatListNotifierProvider.notifier)
                .addChat(chat)
                .then((value) {
                  ref.read(loadingmsgProvider.notifier).state = false;
                });
            ref.read(supabaseChatNotifierProvider.notifier).addChats(chat);

            debugPrint('AI Reply: $message');
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
  final dio = ref.read(dioProviderGemini);
  final client = DioClientMethods(dio);
  return AiDataSource(client);
});
final loadingmsgProvider = StateProvider<bool>((ref) {
  return false;
});
