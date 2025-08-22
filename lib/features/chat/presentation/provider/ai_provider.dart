// import 'package:clean_architutre_learn/features/chat/data/data_sources/ai_data_source.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// f
// final aiDataSourceProvider= Provider<AiDataSource>((ref) {

//   return AiDataSource();
// },);

import 'package:clean_architutre_learn/features/chat/business/usecases/get_message.dart';
import 'package:clean_architutre_learn/features/chat/data/model/ai_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiMessgeNotifier extends StateNotifier<Content> {
  AiMessgeNotifier( this._messge) : super(Content());
  final GetMessage _messge;

  Future<void> getAiReply(String input) async {
    await _messge(input);
  }
}
// final aiMessgeNotifierProvider= StateNotifierProvider<AiMessgeNotifier,Content>((ref) {
// return AiMessgeNotifier(ref );
// },)