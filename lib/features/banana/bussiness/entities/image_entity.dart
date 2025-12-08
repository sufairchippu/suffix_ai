import 'dart:typed_data';

class UserImageEntity {
  final String? id;
  final String userId;
  final DateTime time;
  final String? name;
  final Uint8List bytesData;
  UserImageEntity({
     this.id,
    required this.userId,
    required this.time,
    this.name,
    required this.bytesData,
  });
}
