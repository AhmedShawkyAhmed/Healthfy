import 'package:healthify/src/data/shared_models/doctor_model.dart';
import 'package:healthify/src/data/shared_models/rate_model.dart';
import 'package:healthify/src/data/shared_models/schedule_model.dart';
import 'package:healthify/src/data/shared_models/service_model.dart';

import 'location_model.dart';

class MedicineTypeModel {
  num? id;
  List<RateModel>? rates;
  String? ratesAvg;
  num? ratesCount;
  int? installmentFeature;
  String? type;
  String? image;
  String? name;
  String? aboutUs;
  List<String>? phoneNumbers;
  String? address;
  bool? hasReservations;
  int? reservationId;
  bool? fav;
  List<ScheduleModel>? schedule;
  List<ServiceModel>? service;
  List<DoctorModel>? doctor;
  num? normalDiscount;
  num? packageDiscount;
  LocationModel? locationModel;
  num? rewardPoints;

  MedicineTypeModel({
    this.id,
    this.rates,
    this.ratesAvg,
    this.ratesCount,
    this.image,
    this.name,
    this.installmentFeature,
    this.type,
    this.aboutUs,
    this.phoneNumbers,
    this.address,
    this.hasReservations,
    this.reservationId,
    this.schedule,
    this.service,
    this.doctor,
    this.fav,
    this.normalDiscount,
    this.packageDiscount,
    this.locationModel,
    this.rewardPoints,
  });

  MedicineTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['rates'] != null) {
      rates = <RateModel>[];
      json['rates'].forEach((v) {
        rates!.add(RateModel.fromJson(v));
      });
    }
    ratesAvg = json['rates_avg'];
    ratesCount = json['rates_count'];
    hasReservations = json['has_reservations'];
    reservationId = json['reservation_id'];
    image = json['image'];
    installmentFeature = json['installment_feature'];
    name = json['name'];
    type = json['type'];
    fav = json['Fav'];
    aboutUs = json['about_us'];
    phoneNumbers = json['phone_numbers'].cast<String>();
    address = json['Address'];
    rewardPoints = json['reward_points'];
    if (json['schedule'] != null) {
      schedule = <ScheduleModel>[];
      json['schedule'].forEach((v) {
        schedule!.add(ScheduleModel.fromJson(v));
      });
    }
    if (json['Service'] != null) {
      service = <ServiceModel>[];
      json['Service'].forEach((v) {
        service!.add(ServiceModel.fromJson(v));
      });
    }
    if (json['doctor'] != null) {
      doctor = <DoctorModel>[];
      json['doctor'].forEach((v) {
        doctor!.add(DoctorModel.fromJson(v));
      });
    }
    normalDiscount = json['normal_discount'];
    packageDiscount = json['package_discount'];
    locationModel = json['location_medicine_type'] != null
        ? LocationModel.fromJson(json['location_medicine_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (rates != null) {
      data['rates'] = rates!.map((v) => v.toJson()).toList();
    }
    data['rates_avg'] = ratesAvg;
    data['reward_points'] = rewardPoints;
    data['rates_count'] = ratesCount;
    data['image'] = image;
    data['name'] = name;
    data['has_reservations'] = hasReservations;
    data['reservation_id'] = reservationId;
    data['installment_feature'] = installmentFeature;
    data['type'] = type;
    data['Fav'] = fav;
    data['about_us'] = aboutUs;
    data['phone_numbers'] = phoneNumbers;
    data['Address'] = address;
    if (schedule != null) {
      data['schedule'] = schedule!.map((v) => v.toJson()).toList();
    }
    if (service != null) {
      data['Service'] = service!.map((v) => v.toJson()).toList();
    }
    if (doctor != null) {
      data['doctor'] = doctor!.map((v) => v.toJson()).toList();
    }
    data['normal_discount'] = normalDiscount;
    data['package_discount'] = packageDiscount;
    if (locationModel != null) {
      data['location_medicine_type'] = locationModel!.toJson();
    }
    return data;
  }
}

// class MedicineTypeModel {
//   num? id;
//   String? name;
//   String? aboutUs;
//   List<String>? phoneNumbers;
//   String? address;
//   List<ScheduleModel>? schedule;
//   List<ServiceModel>? service;
//   List<DoctorModel>? doctor;
//   DiscountModel? normalDiscount;
//   DiscountModel? packageDiscount;
//
//   MedicineTypeModel({
//     this.id,
//     this.name,
//     this.aboutUs,
//     this.phoneNumbers,
//     this.address,
//     this.schedule,
//     this.service,
//     this.doctor,
//     this.normalDiscount,
//     this.packageDiscount,
//   });
//
//   MedicineTypeModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     aboutUs = json['about_us'];
//     phoneNumbers = json['phone_numbers'].cast<String>();
//     address = json['Address'];
//     if (json['schedule'] != null) {
//       schedule = <ScheduleModel>[];
//       json['schedule'].forEach((v) {
//         schedule!.add(ScheduleModel.fromJson(v));
//       });
//     }
//     if (json['Service'] != null) {
//       service = <ServiceModel>[];
//       json['Service'].forEach((v) {
//         service!.add(ServiceModel.fromJson(v));
//       });
//     }
//     if (json['doctor'] != null) {
//       doctor = <DoctorModel>[];
//       json['doctor'].forEach((v) {
//         doctor!.add(DoctorModel.fromJson(v));
//       });
//     }
//     normalDiscount = json['normal_discount'] != null
//         ? DiscountModel.fromJson(json['normal_discount'])
//         : null;
//     packageDiscount = json['package_discount'] != null
//         ? DiscountModel.fromJson(json['package_discount'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['about_us'] = aboutUs;
//     data['phone_numbers'] = phoneNumbers;
//     data['Address'] = address;
//     if (schedule != null) {
//       data['schedule'] = schedule!.map((v) => v).toList();
//     }
//     if (service != null) {
//       data['Service'] = service!.map((v) => v.toJson()).toList();
//     }
//     if (doctor != null) {
//       data['doctor'] = doctor!.map((v) => v.toJson()).toList();
//     }
//     if (normalDiscount != null) {
//       data['normal_discount'] = normalDiscount!.toJson();
//     }
//     if (packageDiscount != null) {
//       data['package_discount'] = packageDiscount!.toJson();
//     }
//     return data;
//   }
// }
