// import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';

// State type: AsyncValue<XFile?> - null means "no image selected"
class ImagePickerNotifier extends StateNotifier<AsyncValue<XFile?>> {
  final ImagePicker _picker;
  ImagePickerNotifier([ImagePicker? picker])
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
      if (file == null) {
        state = const AsyncData(null);
        return;
      }
      state = AsyncData(file); // file may be null if user cancelled
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // // Pick multiple images (returns List<XFile> inside AsyncValue)
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

/// Providers
final imagePickerNotifierProvider =
    StateNotifierProvider<ImagePickerNotifier, AsyncValue<XFile?>>(
      (ref) => ImagePickerNotifier(),
    );
final topicSelecetedProvider = StateProvider((ref) => false);
//         import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';

/// Holds the CameraController
// final cameraControllerProvider =
//     StateNotifierProvider<CameraNotifier, AsyncValue<CameraController?>>(
//       (ref) => CameraNotifier(),
//     );

// class CameraNotifier extends StateNotifier<AsyncValue<CameraController?>> {
//   CameraNotifier() : super(const AsyncValue.loading()) {
//     _initCamera();
//   }

//   Future<void> _initCamera() async {
//     try {
//       final cameras = await availableCameras();
//       final controller = CameraController(
//         cameras.first,
//         ResolutionPreset.medium,
//       );
//       await controller.initialize();
//       state = AsyncValue.data(controller);
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }
// }

// /// Selected image state
// final imageStateProvider = StateNotifierProvider<ImageStateNotifier, XFile?>(
//   (ref) => ImageStateNotifier(),
// );

// class ImageStateNotifier extends StateNotifier<XFile?> {
//   ImageStateNotifier() : super(null);

//   void setImage(XFile file) => state = file;
//   void clear() => state = null;
// }

// final imageStoringProrvider = StateNotifierProvider<ImagePickerNoitifier, File>(
//   (ref) {
//     final image=File('path');///
//     return ImagePickerNoitifier(image);
//   },
// );

// class ImagePickerNoitifier extends StateNotifier<File> {
//   ImagePickerNoitifier(this.image) : super(image);
//   File image;
//   final picker = ImagePicker();

//   Future<void> openCamera() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       state = File(pickedFile.path);
//       // image = File(pickedFile.path);
//     }
//   }

//   // open gallery
//   Future<void> openGallery() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       state = File(pickedFile.path);
//     }
//   }
// }
