import 'package:flutter/cupertino.dart';

class NanoSelectionModels {
  final String title;
  final String description;
  final Color cardColor;
  final String? image;
  final List<String> specifications;
  NanoSelectionModels({
    required this.title,
    required this.description,
    required this.cardColor,
    required this.image,
    required this.specifications,
  });
}

class AttachmentItemInscreen {
  final String name;
  final String route;
  final IconData icon;
  const AttachmentItemInscreen({
    required this.icon,
    required this.name,
    required this.route,
  });
}
