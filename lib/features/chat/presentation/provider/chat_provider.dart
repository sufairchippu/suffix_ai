// import 'dart:developer';

// import 'package:clean_architutre_learn/features/chat/business/entities/chat_bubble.dart';
// import 'package:clean_architutre_learn/features/chat/business/repo/chat_bubble_repository.dart';
// import 'package:clean_architutre_learn/features/chat/business/usecases/add_chat.dart';
// import 'package:clean_architutre_learn/features/chat/business/usecases/clear_chats.dart';
// import 'package:clean_architutre_learn/features/chat/business/usecases/delet_chat.dart';
// import 'package:clean_architutre_learn/features/chat/business/usecases/get_chats.dart';
// import 'package:clean_architutre_learn/features/chat/data/data_sources/chat_local_data_source.dart';
// import 'package:clean_architutre_learn/features/chat/data/repo/chat_bubble_repo_impl.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final chatLocalDabsourceProvider = Provider<ChatLocalDataSource>((ref) {
//   return ChatLocalDataSource();
// });

// final chatRepostoryProvider = Provider<ChatBubbleRepository>((ref) {
//   final repos = ref.read(chatLocalDabsourceProvider);
//   return ChatBubbleRepoImpl(repos);
// });

// final getChatProvider = Provider<GetChats>((ref) {
//   final chatBubbleRepo = ref.read(chatRepostoryProvider);
//   return GetChats(chatBubbleRepo);
// });

// // final chatStreamProvider = StreamProvider<List<ChatBubbleModel>>((ref) {
// //   final dataSource = ref.watch(chatLocalDabsourceProvider);
// //   return dataSource.watchChats();
// // });

// ///////////////////////////
// final addChatProvider = Provider<AddChat>((ref) {
//   final chatBubbleRepo = ref.read(chatRepostoryProvider);
//   return AddChat(chatBubbleRepo);
// });
// final deletChatProvider = Provider<DeletChat>((ref) {
//   final chatBubbleRepo = ref.read(chatRepostoryProvider);
//   return DeletChat(chatBubbleRepo);
// });
// final clearChatProvider = Provider<ClearChats>((ref) {
//   final chatBubbleRepo = ref.read(chatRepostoryProvider);
//   return ClearChats(chatBubbleRepo);
// });

// final chatListNotifierProvider =
//     StateNotifierProvider<ChatListNotifier, List<Chatbubble>>((ref) {
//       final getchats = ref.read(getChatProvider);
//       final addchat = ref.read(addChatProvider);
//       final deletchat = ref.read(deletChatProvider);
//       final clerachts = ref.read(clearChatProvider);
//       return ChatListNotifier(getchats, addchat, deletchat, clerachts);
//     });

// class ChatListNotifier extends StateNotifier<List<Chatbubble>> {
//   ChatListNotifier(
//     this._getChats,
//     this._addchats,
//     this._deletChat,
//     this._clerachts,
//   ) : super([]);
//   final GetChats _getChats;
//   final AddChat _addchats;
//   final DeletChat _deletChat;
//   final ClearChats _clerachts;

//   Future<void> loadChats() async {
//     final chtsOrFailire = await _getChats();
//     chtsOrFailire.fold((error) => state = [], (trips) => state = trips);
//   }

//   Future<void> addchats(Chatbubble chat) async {
//     log('addedd. to');
//     await _addchats(chat);
//     await loadChats();
//   }

//   Future<void> removeChat(int chatId) async {
//     await _deletChat(chatId);
//     await loadChats();
//   }

//   Future<void> clearChatts() async {
//     await _clerachts();
//     await loadChats();
//   }
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clean_architutre_learn/features/chat/business/entities/chat_bubble.dart';
import 'package:clean_architutre_learn/features/chat/business/usecases/add_chat.dart';
import 'package:clean_architutre_learn/features/chat/business/usecases/clear_chats.dart';
import 'package:clean_architutre_learn/features/chat/business/usecases/delet_chat.dart';
import 'package:clean_architutre_learn/features/chat/business/usecases/get_chats.dart';
import 'package:clean_architutre_learn/features/chat/business/repo/chat_bubble_repository.dart';
import 'package:clean_architutre_learn/features/chat/data/data_sources/chat_local_data_source.dart';
import 'package:clean_architutre_learn/features/chat/data/repo/chat_bubble_repo_impl.dart';

/// --- Providers for dependencies ---
final chatLocalDataSourceProvider = Provider((ref) => ChatLocalDataSource());

final chatRepositoryProvider = Provider<ChatBubbleRepository>((ref) {
  return ChatBubbleRepoImpl(ref.read(chatLocalDataSourceProvider));
});

final getChatsProvider = Provider(
  (ref) => GetChats(ref.read(chatRepositoryProvider)),
);
final addChatProvider = Provider(
  (ref) => AddChat(ref.read(chatRepositoryProvider)),
);
final deleteChatProvider = Provider(
  (ref) => DeletChat(ref.read(chatRepositoryProvider)),
);
final clearChatProvider = Provider(
  (ref) => ClearChats(ref.read(chatRepositoryProvider)),
);

/// --- AsyncNotifier for managing chats ---
class ChatListNotifier extends AsyncNotifier<List<Chatbubble>> {
  late final GetChats _getChats;
  late final AddChat _addChat;
  late final DeletChat _deleteChat;
  late final ClearChats _clearChats;

  @override
  Future<List<Chatbubble>> build() async {
    _getChats = ref.read(getChatsProvider);
    _addChat = ref.read(addChatProvider);
    _deleteChat = ref.read(deleteChatProvider);
    _clearChats = ref.read(clearChatProvider);

    // Initial load of chats
    return await _fetchChats();
  }

  Future<List<Chatbubble>> _fetchChats() async {
    final result = await _getChats();
    return result.fold((failure) => [], (chats) => chats);
  }

  Future<void> addChat(Chatbubble chat) async {
    final previous = state.value ?? [];
    // Optimistic update
    state = AsyncValue.data([...previous, chat]);

    final result = await AsyncValue.guard(() async {
      await _addChat(chat);
      return await _fetchChats();
    });

    state = result;
  }

  Future<void> deleteChat(int chatId) async {
    await _deleteChat(chatId);
    state = await AsyncValue.guard(() async => await _fetchChats());
  }

  Future<void> clearChats() async {
    await _clearChats();
    state = await AsyncValue.guard(() async => await _fetchChats());
  }
}

/// --- Provider for the notifier ---
final chatListNotifierProvider =
    AsyncNotifierProvider<ChatListNotifier, List<Chatbubble>>(() {
      return ChatListNotifier();
    });

final chatReadMoreProvider = StateProvider<bool>((ref) {
  return false;
});

final newChatNotifierProvider = StateProvider<bool>((ref) {
  return true;
});
// final chatDrawrProvider = StateProvider<bool>((ref) {
//   return false;
// });
final speakingTestProvider = StateProvider<String>((ref) {
  return '';
});
final chatHistoryProvider = StateProvider<bool>((ref) {
  return false;
});

final chatAttachmentProvider = StateProvider<bool>((ref) {
  return false;
});
