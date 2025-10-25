import 'package:flutter_riverpod/flutter_riverpod.dart';

final quizselectedAnswerProvider = StateProvider<String>((ref) {
  return '';
});
final paperTypeOptionProvider = StateProvider<String?>((ref) {
  return ;
});
final topicOptionProvider = StateProvider<String?>((ref) {
  return ;
});
final categeoryOptionProvider = StateProvider<String?>((ref) {
  return ;
});
final searchQueryProvider = StateProvider<String>((ref) => '');