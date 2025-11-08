import 'dart:async';
import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/chat_bubble_model.dart';

class ChatLocalDataSource {
  static const String _dbName = "chat.db";
  static const String _tableName = "chat_bubbles";
  static const int _dbVersion = 1;

  Database? _db;
  // final _controller = StreamController<List<ChatBubbleModel>>.broadcast();
  // // Singleton pattern
  // static final chatbuuble instance = ChatRepository._internal();
  // ChatRepository._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    log('Creating  data base>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            message TEXT NOT NULL,
            time TEXT NOT NULL,
            msgtype INTEGER NOT NULL,
            attachment TEXT,
            chat_set_id TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // ✅ Insert
  Future<int> insertChat(ChatBubbleModel chat) async {
    log('message insertinnggg>>>>>>>>>>>>>>.');
    final db = await database;
    return await db.insert(
      _tableName,
      chat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ✅ Get all
  Future<List<ChatBubbleModel>> getAllChats() async {
    final db = await database;
    final result = await db.query(_tableName, orderBy: "time ASC");
    return result.map((map) => ChatBubbleModel.fromMap(map)).toList();
  }

  Future<ChatBubbleModel?> getSinglChat(int id) async {
    final db = await database;
    final result = await db.query(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return ChatBubbleModel.fromMap(result.first);
    }
    return null;
  }

  // ✅ Update
  Future<int> updateChat(ChatBubbleModel chat) async {
    final db = await database;
    return await db.update(
      _tableName,
      chat.toMap(),
      where: "id = ?",
      whereArgs: [chat.id],
    );
  }

  // ✅ Delete
  Future<int> deleteChat(int id) async {
    final db = await database;
    return await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }

  // ✅ Clear table
  Future<int> clearAllChats() async {
    final db = await database;
    return await db.delete(_tableName);
  }

  Stream<List<ChatBubbleModel>> watchChats() {
    // Example if using sqflite + StreamController
    final controller = StreamController<List<ChatBubbleModel>>();

    loadAndEmit() async {
      final chats = await getAllChats(); // fetch from DB
      controller.add(chats);
    }

    // emit initially
    loadAndEmit();

    // optional: re-emit on DB changes (if you have triggers or manual notify)
    // Provide a method to notify controller.add()

    return controller.stream;
  }

  // Stream<List<ChatBubbleModel>> watchChats() {
  //   _notifyListeners(); // initial emit
  //   return _controller.stream;
  // }

  // Future<void> _notifyListeners() async {
  //   final chats = await getAllChats();
  //   _controller.add(chats);
  // }
}
