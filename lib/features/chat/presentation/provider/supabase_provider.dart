import 'dart:async';

import 'package:clean_architutre_learn/core/service/local_storage/local_keys.dart';
import 'package:clean_architutre_learn/core/service/local_storage/local_storage_service.dart';
import 'package:clean_architutre_learn/features/chat/business/entities/chat_bubble.dart';
import 'package:clean_architutre_learn/features/chat/business/entities/chat_set_model.dart';
import 'package:clean_architutre_learn/features/chat/business/repo/supabase_repository.dart';
import 'package:clean_architutre_learn/features/chat/business/usecases/add_single_chat_remote.dart';
import 'package:clean_architutre_learn/features/chat/business/usecases/clear_whole_chats.dart';
import 'package:clean_architutre_learn/features/chat/business/usecases/delete_chat_remote.dart';
import 'package:clean_architutre_learn/features/chat/business/usecases/get_chat_remote.dart';
import 'package:clean_architutre_learn/features/chat/business/usecases/get_chat_set_remote.dart';
import 'package:clean_architutre_learn/features/chat/data/data_sources/remote_data_source.dart';
import 'package:clean_architutre_learn/features/chat/data/repo/supabase_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatSupabaseDataSourceProvider = Provider((ref) => RemoteDataSource());
final chatSupabaseRepositoryProvider = Provider<SupabaseRepository>(
  (ref) => SupabaseRepoImpl(ref.read(chatSupabaseDataSourceProvider)),
);

final addChatSupaBaseProvider = Provider(
  (ref) => AddSingleChatRemote(ref.read(chatSupabaseRepositoryProvider)),
);
final fetchChatSupaBaseProvider = Provider(
  (ref) => GetChatRemote(ref.read(chatSupabaseRepositoryProvider)),
);
final deletChatSupaBaseProvider = Provider(
  (ref) => DeleteChatRemote(ref.read(chatSupabaseRepositoryProvider)),
);
final getChatSetSupaBaseProvider = Provider(
  (ref) => GetChatSetRemote(ref.read(chatSupabaseRepositoryProvider)),
);
final clearChatSetSupaBaseProvider = Provider(
  (ref) => ClearWholeChats(ref.read(chatSupabaseRepositoryProvider)),
);
//!for set of chat

final supabaseChatSetNotifierProvider =
    AsyncNotifierProvider<SupaBaseChatSetNotifier, List<ChatSetModel>>(() {
      return SupaBaseChatSetNotifier();
    });

class SupaBaseChatSetNotifier extends AsyncNotifier<List<ChatSetModel>> {
  late final DeleteChatRemote _deleteChat;
  late final GetChatSetRemote _getChatSet;
  late final ClearWholeChats _clearALlChats;
  @override
  FutureOr<List<ChatSetModel>> build() {
    _deleteChat = ref.read(deletChatSupaBaseProvider);
    _getChatSet = ref.read(getChatSetSupaBaseProvider);
    _clearALlChats = ref.read(clearChatSetSupaBaseProvider);
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<List<ChatSetModel>> fetchChatSets() async {
    final result = await _getChatSet();
    return result.fold((failure) => [], (chats) => chats);
  }

  Future<void> deletChatSet(String chatSetID) async {
    await _deleteChat(chatSetID);
    state = await AsyncValue.guard(() async => await fetchChatSets());
  }

  Future<void> clearAllChat() async {
    await _clearALlChats();
    state = await AsyncValue.guard(() async => await fetchChatSets());
  }
}

//!for getting fetch dat add data
final supabaseChatNotifierProvider =
    AsyncNotifierProvider<SupaBaseChatNotifier, List<Chatbubble>>(() {
      return SupaBaseChatNotifier();
    });

class SupaBaseChatNotifier extends AsyncNotifier<List<Chatbubble>> {
  late final AddSingleChatRemote _addChat;
  late final GetChatRemote _getChats;

  @override
  FutureOr<List<Chatbubble>> build() async {
    _addChat = ref.read(addChatSupaBaseProvider);
    _getChats = ref.read(fetchChatSupaBaseProvider);
    return await _fetchChats(
      LocalStorageService.getString(LocalServiceKeys.CHAT_SET_ID),
    );
  }

  Future<List<Chatbubble>> _fetchChats(String chatSetID) async {
    final result = await _getChats(chatSetID);
    return result.fold((failure) => [], (chats) => chats);
  }

  Future<void> addChats(Chatbubble chat) async {
    final previous = state.value ?? [];
    // Optimistic update
    state = AsyncValue.data([...previous, chat]);

    final result = await AsyncValue.guard(() async {
      await _addChat(chat);
      return await _fetchChats(chat.chatSetID);
    });

    state = result;
  }
}
