part of 'verify_otp_response.dart';

class VerifyOtpResponseData {
  String? token;
  bool? social;
  bool? user;

  VerifyOtpResponseData({this.token, this.social, this.user});

  VerifyOtpResponseData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    social = json['social'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['social'] = social;
    data['user'] = user;
    return data;
  }
}
