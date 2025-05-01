part 'verify_phone_response_data.dart';

class VerifyPhoneResponse {
  String? message;
  VerifyPhoneResponseData? data;

  VerifyPhoneResponse({this.message, this.data});

  VerifyPhoneResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? VerifyPhoneResponseData.fromJson(json['data'])
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
