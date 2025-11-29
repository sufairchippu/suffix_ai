import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final attachementNotifierProvider =
    StateNotifierProvider<AttachmentNotifier, AsyncValue<List<XFile>>>(
      (ref) => AttachmentNotifier(),
    );

class AttachmentNotifier extends StateNotifier<AsyncValue<List<XFile>>> {
  AttachmentNotifier() : super(const AsyncValue.data([]));
  final ImagePicker _picker = ImagePicker();
  static const int maxximumattamentCount = 3;
  static const int maxfilesizeInMB = 5;
  static const int maxfilesizeInByte = maxfilesizeInMB + 1024 * 1024;
  bool _isPicking = false;

  bool _validatFile(XFile file) {
    final filesize = File(file.path).lengthSync();
    if (filesize > maxfilesizeInByte) {
      log('File Skipped${file.name} size >$maxfilesizeInMB ');
      return false;
    }
    return true;
  }

  List<XFile> _filterValidFiles(List<XFile> files) =>
      files.where(_validatFile).toList();

  void _addMedias(List<XFile> newFiles) {
    state.whenData((oldList) {
      if (oldList.length >= maxximumattamentCount) return;
      final filtered = _filterValidFiles(newFiles);
      final remainingSlot = maxximumattamentCount - oldList.length;
      final updated = [...oldList, ...filtered.take(remainingSlot)];
      state = AsyncValue.data(updated);
      log("Added ${newFiles.length} items. Total = ${updated.length}");
    });
  }

  Future<void> pickMultiImageGallery() async {
    if (_isPicking) return; // prevent double trigger
    _isPicking = true;
    try {
      final List<XFile>? medias = await _picker.pickMultiImage();
      if (medias != null && medias.isNotEmpty) {
        _addMedias(medias);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isPicking = false;
    }
  }

  Future<void> cameraImage() async {
    if (_isPicking) return; // prevent double trigger
    _isPicking = true;
    try {
      final image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        _addMedias([image]);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isPicking = false;
    }
  }

  Future<void> pickDocument() async {
    if (_isPicking) return; // prevent double trigger
    _isPicking = true;
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx', 'xlsx', 'txt', 'zip'],
      );
      if (result != null) {
        final files = result.files
            .where((element) => element.path != null)
            .map((e) => XFile(e.path!))
            .toList();
        _addMedias(files);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isPicking = false;
    }
  }

  void removeAttachment(XFile file) {
    state.whenData((list) {
      final updated = [...list]..remove(file);
      state = AsyncValue.data(updated);
    });
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}
  //   Future<void> pickMultVideoeGallery() async {
  //     try {
  //       final List<XFile>? medias = await _picker.pickMultiVideo();
  //       if (medias != null && medias.isNotEmpty) {
  //         _addMedias(medias);
  //       }
  //     } catch (e, st) {
  //       state = AsyncValue.error(e, st);
  //     }
  //   }
  //  Future<void> cameraVideo() async {
  //     try {
  //       final image = await _picker.pickVideo(source: ImageSource.camera);
  //       if (image != null) {
  //         _addMedias([image]);
  //       }
  //     } catch (e, st) {
  //       state = AsyncValue.error(e, st);
  //     }

  // void _addSingle(XFile file) {
  //   state.whenData((oldList) {
  //     if (oldList.length>=maxximumattamentCount) return ;
  //     if () {

  //     }
  //     final updated = [...oldList, file];
  //     state = AsyncValue.data(updated);
  //   });
  // }
  //   }

