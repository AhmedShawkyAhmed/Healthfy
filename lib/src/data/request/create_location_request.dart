import 'package:healthify/src/data/shared_models/location_address_model.dart';

class CreateLocationRequest {
  final num lat;
  final num lon;
  final String address;
  final String type;
  final LocationAddressModel addressModel;

  const CreateLocationRequest({
    required this.lat,
    required this.lon,
    required this.address,
    required this.type,
    required this.addressModel,
  });

  Map<String, dynamic> toJson() {
    return {
      'latitude': lat,
      'longitude': lon,
      'address': address,
      'type': type,
      'address1': addressModel.toJson(),
    };
  }
}
