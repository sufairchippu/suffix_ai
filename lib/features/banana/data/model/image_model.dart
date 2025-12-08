import 'package:clean_architutre_learn/features/banana/bussiness/entities/image_entity.dart';

class UserImageModel extends UserImageEntity {
  UserImageModel({
     super.id,
    required super.userId,
    required super.time,
    super.name,
    required super.bytesData,
  });

  factory UserImageModel.fromEntity(UserImageEntity image) => UserImageModel(
    id: image.id,
    userId: image.userId,
    time: image.time,
    name: image.name,
    bytesData: image.bytesData,
  );
  UserImageEntity toEntity() =>
      UserImageEntity(id: id, userId: userId, time: time, bytesData: bytesData);

  Map<String, dynamic> toMap() => {
    // 'id': id,
    'user_id': userId,
    'time': time.toIso8601String(),
    'name': name,
    'bytesdata': bytesData,
  };

  factory UserImageModel.fromMap(Map<String, dynamic> map) {
    return UserImageModel(
      id: map['id'],
      userId: map['user_id'],
      time: DateTime.parse(map['time']),
      name: map['name'],
      bytesData: map['bytesdata'],
    );
  }
}
