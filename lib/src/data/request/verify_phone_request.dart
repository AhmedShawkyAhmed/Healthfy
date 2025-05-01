class VerifyPhoneRequest {
  final String phoneNumber;
  final String dialCode;

  const VerifyPhoneRequest({
    required this.phoneNumber,
    required this.dialCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phoneNumber,
      'type': "user",
      'dial_code': dialCode,
    };
  }
}
