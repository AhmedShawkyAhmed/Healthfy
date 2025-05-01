part 'register_response_data.dart';

class RegisterResponse {
  String? message;
  RegisterResponseData? data;

  RegisterResponse({this.message, this.data});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? RegisterResponseData.fromJson(json['data'])
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
