import 'package:dio/dio.dart';

class RegisterRequest {
  final String name;
  final String? nickname;
  final String birthdate;
  final String? email;
  final String? image;
  final int gender;

  const RegisterRequest({
    required this.name,
    this.nickname,
    required this.birthdate,
    this.email,
    this.image,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (nickname != null) 'nickName': nickname,
      'birth': birthdate,
      'email': email,
      'userDetails[type]': "user",
      'gender': gender,
      if (image != null) 'image': MultipartFile.fromFileSync(image!),
    };
  }
}
