class CreateLocationResponse {
  String? message;
  List<dynamic>? data;

  CreateLocationResponse({
    required String message,
    required List<dynamic> data,
  });

  CreateLocationResponse.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(v);
      });
    }
  }
}
