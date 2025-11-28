import 'dart:io';

import 'package:clean_architutre_learn/core/utils/extenstion.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class Validators {
  static FormFieldValidator<String> emptyPasswordValidator() {
    return (value) {
      if (value == null || value.isEmpty || value.trim().isEmpty) {
        return "Invalid password";
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String> mobileNumberValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return "Invalid Phone number";
      } else if (value.length != 10) {
        return "Invalid Phone number";
      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        return "Invalid Phone number";
      } else if (value.startsWith("0")) {
        return "Invalid Phone number";
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String> leaveReasonValidator() {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return 'Reason is required';
      }
      final regex = RegExp(r'^[a-zA-Z\s]+$');
      if (!regex.hasMatch(value.trim())) {
        return 'Only alphabets and spaces are allowed';
      }
      return null;
    };
  }

  static FormFieldValidator<String> nameValidator(String data) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $data name';
      }
      if (value.trim().length < 3) {
        return '${data.capitalizeFirstLetter()} name must be at least 3 characters';
      }
      return null;
    };
  }

  static FormFieldValidator<String> emptyPhoneNumberValidator(String data) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $data number';
      }
      return null;
    };
  }

  static FormFieldValidator<String> doctorPhoneNumberValidator() {
    return (value) {
      if (value != null && value.isNotEmpty) {
        if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
          return 'Please enter a valid 10-digit number';
        }
      }
      return null;
    };
  }

  static FormFieldValidator<String> emailValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter Email';
      }
      if (value.isNotEmpty) {
        if (!value.contains('@') || !value.contains('.')) {
          return 'Please enter a valid email';
        }
      }
      return null;
    };
  }

  static FormFieldValidator<String> addressValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter address';
      }
      if (value.trim().length < 3) {
        return 'Address must be at least 3 characters';
      }
      return null;
    };
  }

  static FormFieldValidator<String> pincodeValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter pincode';
      }
      if (!RegExp(r'^[1-9][0-9]{5}$').hasMatch(value)) {
        return 'Enter a valid 6-digit pincode';
      }
      return null;
    };
  }

  static FormFieldValidator<String> gstValidator() {
    return (value) {
      if (value != null && value.isNotEmpty) {
        if (!RegExp(
          r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$',
        ).hasMatch(value.toUpperCase())) {
          return 'Enter a valid GST number';
        }
      }
      return null;
    };
  }

  static FormFieldValidator<String> amountValidator() {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return 'Please enter quantity';
      }
      final numValue = num.tryParse(value.trim());
      if (numValue == null) {
        return 'Enter a valid number';
      }
      if (numValue <= 0) {
        return 'Quantity must be greater than 0';
      }
      return null;
    };
  }

  static String fileType(XFile file) {
    final ext = file.name.toLowerCase();
    if (ext.endsWith('.jpg') ||
        ext.endsWith('.jpeg') ||
        ext.endsWith('.png') ||
        ext.endsWith('.gif')) {
      return "image";
    } else if (ext.endsWith('.pdf')) {
      return "pdf";
    } else if (ext.endsWith('.docx')) {
      return "doc";
    } else if (ext.endsWith('.xlsx')) {
      return "excel";
    } else if (ext.endsWith('.zip')) {
      return "zip";
    }
    return "other";
  }

  static IconData fileIcon(String type) {
    switch (type) {
      case "image":
        return CupertinoIcons.photo;
      case "pdf":
        return CupertinoIcons.doc_on_clipboard_fill;
      case "doc":
        return CupertinoIcons.doc_text_fill;
      case "excel":
        return CupertinoIcons.table;
      case "zip":
        return CupertinoIcons.archivebox_fill;
      default:
        return CupertinoIcons.doc;
    }
  }

  static String fileTypeForLocal(File file) {
    final name = file.path.toLowerCase(); // use file path

    // IMAGE
    if (_imageExt.any(name.endsWith)) return "image";

    // VIDEO
    if (_videoExt.any(name.endsWith)) return "video";

    // PDF
    if (name.endsWith('.pdf')) return "pdf";

    // DOCUMENT
    if (_docExt.any(name.endsWith)) return "doc";

    // EXCEL
    if (_excelExt.any(name.endsWith)) return "excel";

    // ZIP
    if (_zipExt.any(name.endsWith)) return "zip";

    return "other";
  }

  // Supported extensions:
  static const _imageExt = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];

  static const _videoExt = ['.mp4', '.mov', '.mkv', '.avi', '.flv', '.wmv'];

  static const _docExt = ['.doc', '.docx', '.txt', '.rtf', '.ppt', '.pptx'];

  static const _excelExt = ['.xls', '.xlsx'];

  static const _zipExt = ['.zip', '.rar', '.7z'];
}
