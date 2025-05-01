part of 'verify_phone_response.dart';

class VerifyPhoneResponseData {
  String? token;
  int? otp;

  VerifyPhoneResponseData({this.token, this.otp});

  VerifyPhoneResponseData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['otp'] = otp;
    return data;
  }
}