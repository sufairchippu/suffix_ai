import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginPasswordProvider = StateProvider<bool>((ref) {
  return true;
});
final loginConformPasswordProvider = StateProvider<bool>((ref) {
  return true;
});
final loginMethodeProvider = StateProvider<bool>((ref) {
  return false;
});
