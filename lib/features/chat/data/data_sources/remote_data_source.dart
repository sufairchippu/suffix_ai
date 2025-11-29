import 'dart:developer';
import 'package:clean_architutre_learn/core/constants/app_constants.dart';
import 'package:clean_architutre_learn/core/service/local_storage/local_keys.dart';
import 'package:clean_architutre_learn/core/service/local_storage/local_storage_service.dart';
import 'package:clean_architutre_learn/features/chat/business/entities/chat_set_model.dart';
import 'package:clean_architutre_learn/features/chat/data/model/chat_bubble_model.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteDataSource {
  final supabase = Supabase.instance.client;
  late final user =
      supabase.auth.currentUser ?? Supabase.instance.client.auth.currentUser!;

  Future<void> inserttoRemote(ChatBubbleModel chat) async {
    try {
      debugPrint("Current user: ${supabase.auth.currentUser}");
      await supabase.from(AppConstants.chattable).insert({
        'user_id': user.id,
        'chat_set_id': LocalStorageService.getString(
          LocalServiceKeys.CHAT_SET_ID,
        ),
        'message': chat.message,
        'msgtype': chat.msgtype.name,
        'time': chat.time,
        'attachments': chat.attachment?.map((e) => e.toMap()).toList(),
        'created_at': DateTime.now().toUtc().toIso8601String(),
      });
    } catch (e) {
      debugPrint('Error message. $e}');
    }
  }

  Future<List<ChatBubbleModel>> getchats(String chatSetID) async {
    final respo = await supabase
        .from(AppConstants.chattable)
        .select()
        .eq('user_id', user.id)
        .eq('chat_set_id', chatSetID)
        .order('created_at', ascending: true);
    debugPrint("Fetching chats with:");
    debugPrint("user.id        = ${user.id}");
    debugPrint("chatSetID      = $chatSetID");
    debugPrint("Supabase response: $respo");
    final chat = respo.map((e) => ChatBubbleModel.fromMap(e)).toList();

    log('${chat}');
    return chat;
  }

  //!
  Future<void> clearWholeData() async {
    await supabase.from(AppConstants.chattable).delete().eq('user_id', user.id);
  }

  Future<void> deleteChat(String chatSetID) async {
    await supabase
        .from(AppConstants.chattable)
        .delete() //add udid user id to all the funtion get only userwise adata
        .eq('user_id', user.id)
        .eq('chat_set_id', chatSetID);
  }

  Future<List<ChatSetModel>> getWholeChatsets() async {
    final respo = await supabase.rpc(AppConstants.chatSetTable);
    final chatset = (respo as List<dynamic>)
        .map((e) => ChatSetModel.fromJson(e))
        .toList();

    log("${chatset[0]} the data chat set");
    return chatset;
  }

  // get wholechatset
}
