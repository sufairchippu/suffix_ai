import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'flavor_config.dart';

final flavorProvider = Provider<FlavorConfig>((ref) {
  return FlavorConfig.instance;
});