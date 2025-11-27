import 'dart:async';
import 'package:clean_architutre_learn/core/constants/app_constants.dart';
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
import 'package:supabase_flutter/supabase_flutter.dart';

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
  RealtimeChannel? _channel;

  @override
  FutureOr<List<ChatSetModel>> build() async {
    _deleteChat = ref.read(deletChatSupaBaseProvider);
    _getChatSet = ref.read(getChatSetSupaBaseProvider);
    _clearALlChats = ref.read(clearChatSetSupaBaseProvider);
    _startRealtimeListener(); // 👈 ADD THIS

    return await fetchChatSets();
  }

  // Future<void> fetchAndUpdate() async {
  //   state = AsyncValue.data(await fetchChatSets());
  // }

  Future<List<ChatSetModel>> fetchChatSets() async {
    final result = await _getChatSet();
    return result.fold((failure) => [], (chats) => chats);
  }
    void _startRealtimeListener() {
    _channel = Supabase.instance.client.channel('chat_messages_channel')
      ..onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: 'chat_messages',
        callback: (payload) {
          _refreshChatSet(); // 👈 refresh UI
        },
      )
      ..subscribe();
  }
//   void _startRealtimeListener() {
//   final channel = Supabase.instance.client.channel('chat_messages_channel')
//     .onPostgresChanges(
//       event: PostgresChangeEvent.all,
//       schema: 'public',
//       table: 'chat_messages',
//       callback: (payload) {
//         fetchAndUpdate(); // refresh RPC result
//       },
//     )
//     .subscribe();

//   _subscription = channel.stream.listen((_) {});
// }

  // void _startRealtimeListener() {
  //   // Avoid creating multiple channels
  //   _channel?.unsubscribe();

  //   _channel = Supabase.instance.client
  //       .channel(AppConstants.chatmesgChannal)
  //       .onPostgresChanges(
  //         event: PostgresChangeEvent.all,
  //         schema: 'public',
  //         table: AppConstants.chatSetTable,
  //         callback: (payload) {
  //           _refreshChatSet();
  //         },
  //       )
  //       // .onPostgresChanges(
  //       //   event: PostgresChangeEvent.update,
  //       //   schema: 'public',
  //       //   table: AppConstants.chatSetTable,
  //       //   callback: (payload) {
  //       //     _refreshChatSet();
  //       //   },
  //       // )
  //       // .onPostgresChanges(
  //       //   event: PostgresChangeEvent.delete,
  //       //   schema: 'public',
  //       //   table: AppConstants.chatSetTable,
  //       //   callback: (payload) {
  //       //     _refreshChatSet();
  //       //   },
  //       // )
  //       .subscribe();
  // }

  Future<void> _refreshChatSet() async {
    state = AsyncValue.data(await fetchChatSets());
  }

  Future<void> deletChatSet(String chatSetID) async {
    await _deleteChat(chatSetID);
    await _refreshChatSet();
    // state = await AsyncValue.guard(() async => await fetchChatSets());

  }

  Future<void> clearAllChat() async {
    await _clearALlChats();
     await _refreshChatSet();
    // state = await AsyncValue.guard(() async => await fetchChatSets());
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
    return await fetchChats(
      LocalStorageService.getString(LocalServiceKeys.CHAT_SET_ID),
    );
  }

  Future<List<Chatbubble>> fetchChats(String chatSetID) async {
    final result = await _getChats(chatSetID);
    return result.fold((failure) => [], (chats) => chats);
  }

  Future<void> addChats(Chatbubble chat) async {
    final previous = state.value ?? [];
    // Optimistic update
    state = AsyncValue.data([...previous, chat]);

    final result = await AsyncValue.guard(() async {
      await _addChat(chat);
      return await fetchChats(chat.chatSetID);
    });

    state = result;
  }
}

final remotchatLoading = StateProvider<bool>((ref) => false);
  // void _startRealtimeListener() {
  //   _channel = Supabase.instance.client
  //       .channel(AppConstants.chatmesgChannal)
  //       .onPostgresChanges(
  //         event: PostgresChangeEvent.insert,
  //         schema: 'public',
  //         table: AppConstants.chattable,
  //         callback: (payload) {
  //           fetchAndUpdate();
  //         },
  //       )
  //       .onPostgresChanges(
  //         event: PostgresChangeEvent.update,
  //         schema: 'public',
  //         table: AppConstants.chattable,
  //         callback: (payload) {
  //           fetchAndUpdate();
  //         },
  //       )
  //       .onPostgresChanges(
  //         event: PostgresChangeEvent.delete,
  //         schema: 'public',
  //         table: AppConstants.chattable,
  //         callback: (payload) {
  //           fetchAndUpdate();
  //         },
  //       )
  //       .subscribe();
  // }
//    _startRealtimeListener();//in init build
