class AddRateResponse {
  String? message;
  List<dynamic>? data;

  AddRateResponse({
    required String message,
    required List<dynamic> data,
  });

  AddRateResponse.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(v);
      });
    }
  }
}
