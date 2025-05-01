part 'verify_otp_response_data.dart';

class VerifyOtpResponse {
  String? message;
  VerifyOtpResponseData? data;

  VerifyOtpResponse({this.message, this.data});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? VerifyOtpResponseData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
