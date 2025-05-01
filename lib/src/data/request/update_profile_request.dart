import 'package:dio/dio.dart';

class UpdateProfileRequest {
  final String? name;
  final String? nickname;
  final String? birthdate;
  final String? email;
  final String? image;

  const UpdateProfileRequest({
    this.name,
    this.nickname,
    this.birthdate,
    this.email,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (nickname != null) 'nickName': nickname,
      if (birthdate != null) 'birth': birthdate,
      if (email != null) 'email': email,
      if (image != null) 'image': MultipartFile.fromFileSync(image!),
    };
  }
}
