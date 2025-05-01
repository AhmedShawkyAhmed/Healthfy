part of 'register_response.dart';

class RegisterResponseData {
  String? token;

  RegisterResponseData({this.token});

  RegisterResponseData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}