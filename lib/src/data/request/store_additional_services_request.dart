class StoreAdditionalServicesRequest {
  final num reservationId;
  final List<ServiceRequest> services;

  StoreAdditionalServicesRequest({
    required this.reservationId,
    required this.services,
  });

  Map<String, dynamic> toJson() => {
        "reservation_id": reservationId,
        "services": services.map((e) => e.toJson()).toList(),
      };
}

class ServiceRequest {
  final num id;
  final num price;

  ServiceRequest({
    required this.id,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
      };
}
