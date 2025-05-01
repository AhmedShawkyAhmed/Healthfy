import 'package:healthify/src/data/request/create_location_request.dart';
import 'package:healthify/src/data/shared_models/location_address_model.dart';

class UpdateLocationRequest extends CreateLocationRequest {
  final num id;

  const UpdateLocationRequest({
    required this.id,
    required num lat,
    required num lon,
    required String address,
    required String type,
    required LocationAddressModel addressModel,
  }) : super(
          lat: lat,
          lon: lon,
          address: address,
          type: type,
          addressModel: addressModel,
        );

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': lat,
      'longitude': lon,
      'address': address,
      'type': type,
      'address1': addressModel.toJson(),
    };
  }
}
