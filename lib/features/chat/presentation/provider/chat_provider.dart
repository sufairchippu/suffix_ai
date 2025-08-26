import 'dart:developer';

import 'package:clean_architutre_learn/features/chat/business/entities/chat_bubble.dart';
import 'package:clean_architutre_learn/features/chat/business/repo/chat_bubble_repository.dart';
import 'package:clean_architutre_learn/features/chat/business/usecases/add_chat.dart';
import 'package:clean_architutre_learn/features/chat/business/usecases/clear_chats.dart';
import 'package:clean_architutre_learn/features/chat/business/usecases/delet_chat.dart';
import 'package:clean_architutre_learn/features/chat/business/usecases/get_chats.dart';
import 'package:clean_architutre_learn/features/chat/data/data_sources/chat_local_data_source.dart';
import 'package:clean_architutre_learn/features/chat/data/repo/chat_bubble_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/chat_bubble_model.dart';

final chatLocalDabsourceProvider = Provider<ChatLocalDataSource>((ref) {
  return ChatLocalDataSource();
});

final chatRepostoryProvider = Provider<ChatBubbleRepository>((ref) {
  final repos = ref.read(chatLocalDabsourceProvider);
  return ChatBubbleRepoImpl(repos);
});

final getChatProvider = Provider<GetChats>((ref) {
  final chatBubbleRepo = ref.read(chatRepostoryProvider);
  return GetChats(chatBubbleRepo);
});
// //!streamming chatt
final chatLocalDataSourceProvider = Provider<ChatLocalDataSource>((ref) {
  final dataSource = ChatLocalDataSource();
  // ref.onDispose(() => dataSource.dispose());
  return ChatLocalDataSource();
});

final chatStreamProvider = StreamProvider<List<ChatBubbleModel>>((ref) {
  final dataSource = ref.watch(chatLocalDataSourceProvider);
  return dataSource.watchChats();
});

///////////////////////////
final addChatProvider = Provider<AddChat>((ref) {
  final chatBubbleRepo = ref.read(chatRepostoryProvider);
  return AddChat(chatBubbleRepo);
});
final deletChatProvider = Provider<DeletChat>((ref) {
  final chatBubbleRepo = ref.read(chatRepostoryProvider);
  return DeletChat(chatBubbleRepo);
});
final clearChatProvider = Provider<ClearChats>((ref) {
  final chatBubbleRepo = ref.read(chatRepostoryProvider);
  return ClearChats(chatBubbleRepo);
});

final chatListNotifierProvider =
    StateNotifierProvider<ChatListNotifier, List<Chatbubble>>((ref) {
      final getchats = ref.read(getChatProvider);
      final addchat = ref.read(addChatProvider);
      final deletchat = ref.read(deletChatProvider);
      final clerachts = ref.read(clearChatProvider);
      return ChatListNotifier(getchats, addchat, deletchat, clerachts);
    });

class ChatListNotifier extends StateNotifier<List<Chatbubble>> {
  ChatListNotifier(
    this._getChats,
    this._addchats,
    this._deletChat,
    this._clerachts,
  ) : super([]);
  final GetChats _getChats;
  final AddChat _addchats;
  final DeletChat _deletChat;
  final ClearChats _clerachts;

  Future<void> loadChats() async {
    final chtsOrFailire = await _getChats();
    chtsOrFailire.fold((error) => state = [], (trips) => state = trips);
  }

  Future<void> addchats(Chatbubble chat) async {
    log('addedd. to');
    await _addchats(chat);
    await loadChats();
  }

  Future<void> removeChat(int chatId) async {
    await _deletChat(chatId);
    await loadChats();
  }

  Future<void> clearChatts() async {
    await _clerachts();
    await loadChats();
  }
}


final chatReadMoreProvider = StateProvider <bool>((ref) {
  return false;
});

final chatDrawrProvider = StateProvider <bool>((ref) {
  return false;
});