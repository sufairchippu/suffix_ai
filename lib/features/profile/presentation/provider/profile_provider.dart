import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvidernNotifier extends StateNotifier<AsyncValue<XFile?>> {
  final ImagePicker _picker;
  ProfileProvidernNotifier([ImagePicker? picker])
    : _picker = picker ?? ImagePicker(),
      super(const AsyncData(null));

  /// Pick single image from given source
  Future<void> pick(ImageSource source) async {
    state = const AsyncLoading();
    try {
      final XFile? file = await _picker.pickImage(
        source: source,
        maxWidth: 2000,
        maxHeight: 2000,
        imageQuality: 85,
      );
      state = AsyncData(file); // file may be null if user cancelled
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // Pick multiple images (returns List<XFile> inside AsyncValue)
  // Future<void> pickMulti() async {
  //   state = const AsyncLoading();
  //   try {
  //     final List<XFile>? files = await _picker.pickMultiImage(imageQuality: 80);
  //     // for single-state approach you might store only first or keep a separate provider
  //     // Here we just convert to first file for demo:
  //     state = AsyncData(files != null && files.isNotEmpty ? files.first : null);
  //   } catch (e, st) {
  //     state = AsyncError(e, st);
  //   }
  // }

  /// Clear selection
  void clear() => state = const AsyncData(null);
}

final profileImageNotifierProvider =
    StateNotifierProvider<ProfileProvidernNotifier, AsyncValue<XFile?>>((ref) {
      return ProfileProvidernNotifier();
    });
