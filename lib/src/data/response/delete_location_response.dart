class DeleteLocationResponse {
  String? message;
  List<dynamic>? data;

  DeleteLocationResponse({
    required String message,
    required List<dynamic> data,
  });

  DeleteLocationResponse.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(v);
      });
    }
  }
}
