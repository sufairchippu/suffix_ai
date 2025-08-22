import 'package:clean_architutre_learn/core/error/failures.dart';
import 'package:clean_architutre_learn/features/chat/business/repo/ai_responce_repository.dart';
import 'package:clean_architutre_learn/features/chat/data/data_sources/ai_data_source.dart';
import 'package:clean_architutre_learn/features/chat/data/model/ai_response_model.dart';
import 'package:dartz/dartz.dart';

class AiResponseRepoImpl implements AiResponceRepository {
  final AiDataSource aidata;
  AiResponseRepoImpl(this.aidata);
  @override
  Future<Either<Failure, Content>> getMessage(String data) async {


    try {
      final getData=await aidata.getAiresponse(data);
      return right(getData!);
    } catch (e) {
      return left(SomeSpecificError(e.toString()));
      
    }

  }
}
//  try {
//       final getdata = await localchat.getAllChats();

//       return right(getdata.map((e) => e.toEntity()).toList());
//     } catch (e) {
//       return left(SomeSpecificError(e.toString()));
//     }