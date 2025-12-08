import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:clean_architutre_learn/core/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Download {
  static Future<bool> requestStoragePermission() async {
    final status = await Permission.manageExternalStorage.request();
    return status.isGranted;
  }

  static Future<void> saveUnit8ListTodevice(
    BuildContext context,
    Uint8List data,
    String filename,
  ) async {
    // final hasPermissio = await requestStoragePermission();

    try {
      // if (await Permission.photos.request().isDenied) {
      //   return;
      // }
      // if (hasPermissio) {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}$filename';
      final file = File(filePath);
      await file.writeAsBytes(data);
      // final _downloadDir = Directory('/storage/emulated/0/Download');
      // if (!_downloadDir.existsSync()) {
      //   await _downloadDir.create(recursive: true);
      // }
      // final file = File('${_downloadDir.path}/$filename.png');
      // await file.writeAsBytes(data);
      Uiutils.cupertinoSnackBar(
        context,
        'The Image is downloaded to your device in $filePath',
        false,
      );
      // } else {
      //   Uiutils.cupertinoSnackBar(
      //     context,
      //     'Failed to download image,approve the access',
      //   );
      // await Permission.storage.request();
      // }
    } catch (e) {
      log(" error on dowloading $e");
      Uiutils.cupertinoSnackBar(
        context,
        'Failed to download image, something went wrong',
        true,
      );
    }
  }
}
