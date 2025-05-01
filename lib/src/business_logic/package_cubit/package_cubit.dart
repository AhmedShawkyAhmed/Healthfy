import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/data/resonses/my_package_response.dart';
import 'package:healthify/src/data/resonses/package_response.dart';
import 'package:healthify/src/services/dio_helper.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/enums.dart';
import '../../data/models/person.dart';

part 'package_state.dart';

class PackageCubit extends Cubit<PackageState> {
  PackageCubit() : super(PackageInitial());

  static PackageCubit get(context) => BlocProvider.of(context);
  PackageResponse? packageResponse;
  MyPackageResponse? myPackageResponse;
  String? packageId;
  bool? married;
  String type = "myPackage";

  Future getHealthPackage() async {
    try {
      emit(GetPackageLoading());
      final response = await DioHelper.getData(
        url: EndPoints.epGetHealthPackage,
      );
      logSuccess("PackageCubit getHealthPackage Response: $response");
      packageResponse = PackageResponse.fromJson(response.data);
      emit(GetPackageSuccess());
    } on DioException catch (n) {
      emit(GetPackageError());
      logError(n.toString());
    } catch (e) {
      emit(GetPackageError());
      logError(e.toString());
    }
  }

  Future getMyHealthPackage() async {
    try {
      emit(GetMyPackageLoading());
      final response = await DioHelper.getData(
        url: EndPoints.epGetMyHealthPackage,
      );
      logSuccess("PackageCubit getMyHealthPackage Response: $response");
      myPackageResponse = MyPackageResponse.fromJson(response.data);
      emit(GetPackageSuccess());
    } on DioException catch (n) {
      emit(GetMyPackageError());
      logError("getMyHealthPackage response error: $n");
    } catch (e) {
      emit(GetMyPackageError());
      logError("getMyHealthPackage error: $e");
    }
  }

  Future<Map<String, dynamic>> pay({
    required int packageId,
    required int paymentType,
    required String deliveryAddress,
    required num deliveryLatitude,
    required num deliveryLongitude,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(SubscribePackageLoading());
      final res = await DioHelper.postData(
        url: EndPoints.epaySubscription,
        body: {
          "subscription_id": packageId,
          "payment_type": paymentType,
          "delivery_location": {
            "address": deliveryAddress,
            "latitude": deliveryLatitude,
            "longitude": deliveryLongitude,
          },
          //"married":married,
        },
      );
      logSuccess("PackageCubit subscribeHealthPackage Response: ${res.data}");
      afterSuccess();
      // if (res.data is Map) {
      //   (res.data['message'] as String).toToastSuccess();
      // }
      emit(SubscribePackageSuccess());
      // if (res.data is String) {
      return res.data;
      // }
    } on DioException catch (n) {
      emit(SubscribePackageError());
      logError(n.response.toString());
      return {};
    } catch (e) {
      emit(SubscribePackageError());
      logError(e.toString());
      return {};
    }
  }

  Future subscribeHealthPackage({
    required int packageId,
    bool? married,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(SubscribePackageLoading());
      await DioHelper.postData(url: EndPoints.epSubscribeHealthPackage, body: {
        "health_package_id": packageId,
        //"married":married,
      }).then((value) {
        if (value.data['message'] != null) {
          showToast(
            value.data['message'].replaceAll("api.", ""),
            ToastState.success,
          );
        }
        logSuccess(
            "PackageCubit subscribeHealthPackage Response: ${value.data}");
        afterSuccess();
        emit(SubscribePackageSuccess());
      });
    } on DioException catch (n) {
      emit(SubscribePackageError());
      logError(n.toString());
    } catch (e) {
      emit(SubscribePackageError());
      logError(e.toString());
    }
  }

  XFile? personImage;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController partnerController = TextEditingController();
  List<TextEditingController> sonOrDaughterNameControllers = [];
  List<TextEditingController> broOrSisNameControllers = [];
  List<TextEditingController> fatherOrMotherNameControllers = [];
  Person? father;
  Person? mother;
  Person? partner;
  List<Person> children = [];
  List<Person> siblings = [];
  List<Person> motherAndFather = [];

  void idle() {
    father = null;
    mother = null;
    personImage = null;
    partner = null;
    fullNameController.text = '';
    phoneController.text = '';
    fatherNameController.text = '';
    motherNameController.text = '';
    partnerController.text = '';
    sonOrDaughterNameControllers.clear();
    broOrSisNameControllers.clear();
    fatherOrMotherNameControllers.clear();
    type = "myPackage";
    children.clear();
    siblings.clear();
    motherAndFather.clear();
  }

  Future addUserToPackage({
    required int subscriptionId,
    required Person person,
    required int married,
    required VoidCallback afterSuccess,
  }) async {
    try {
      logError(motherAndFather.length.toString());
      logError(children.length.toString());
      logError(siblings.length.toString());
      emit(SubscribePackageLoading());
      final formData = FormData.fromMap({
        "subscription_id": subscriptionId,
        if (person.imagePath != null)
          "image": await MultipartFile.fromFile(
            person.imagePath!,
          ),
        'name': person.name,
        'phone': person.mobile,
        'married': married,
      });
      if (fatherNameController.text.isNotEmpty) {
        if (father!.imagePath != null) {
          formData.files.add(
            MapEntry(
              'father[image]',
              await MultipartFile.fromFile(father!.imagePath!),
            ),
          );
        }
        formData.fields.add(MapEntry('father[name]', father!.name!));
        formData.fields.add(MapEntry('father[phone]', father!.mobile!));
      }
      if (motherNameController.text.isNotEmpty) {
        if (mother!.imagePath != null) {
          formData.files.add(
            MapEntry(
              'mother[image]',
              await MultipartFile.fromFile(mother!.imagePath!),
            ),
          );
        }
        formData.fields.add(MapEntry('mother[name]', mother!.name!));
        formData.fields.add(MapEntry('mother[phone]', mother!.mobile!));
      }
      if (partnerController.text.isNotEmpty) {
        if (partner!.imagePath != null) {
          formData.files.add(
            MapEntry(
              'partner[image]',
              await MultipartFile.fromFile(partner!.imagePath!),
            ),
          );
        }
        formData.fields.add(MapEntry('partner[name]', partner!.name!));
        formData.fields.add(MapEntry('partner[phone]', partner!.mobile!));
      }
      for (var i in children) {
        if (i.imagePath != null) {
          formData.files.add(
            MapEntry(
              'children[${children.indexOf(i)}][image]',
              await MultipartFile.fromFile(i.imagePath!),
            ),
          );
        }
        formData.fields
            .add(MapEntry('children[${children.indexOf(i)}][name]', i.name!));
        formData.fields.add(
            MapEntry('children[${children.indexOf(i)}][phone]', i.mobile!));
      }
      for (var i in motherAndFather) {
        if (i.imagePath != null) {
          formData.files.add(
            MapEntry(
              'parent[${motherAndFather.indexOf(i)}][image]',
              await MultipartFile.fromFile(i.imagePath!),
            ),
          );
        }
        formData.fields.add(
            MapEntry('parent[${motherAndFather.indexOf(i)}][name]', i.name!));
        formData.fields.add(MapEntry(
            'parent[${motherAndFather.indexOf(i)}][phone]', i.mobile!));
      }
      for (var i in siblings) {
        if (i.imagePath != null) {
          formData.files.add(
            MapEntry(
              'siblings[${children.indexOf(i)}][image]',
              await MultipartFile.fromFile(i.imagePath!),
            ),
          );
        }
        formData.fields
            .add(MapEntry('siblings[${siblings.indexOf(i)}][name]', i.name!));
        formData.fields.add(
            MapEntry('siblings[${siblings.indexOf(i)}][phone]', i.mobile!));
      }
      logWarning(formData.fields.length.toString());
      logWarning(formData.files.length.toString());
      await DioHelper.postData(
              url: EndPoints.eAddUsersSubscription,
              formData: formData,
              isForm: true)
          .then((value) {
        if (value.data['message'] != null) {
          showToast(
            value.data['message'].replaceAll("api.", ""),
            ToastState.success,
          );
        }
        logSuccess(
            "PackageCubit renewSubscribePackage Response: ${value.data}");
        logWarning(value.toString());
        logWarning(value.toString());
        afterSuccess();
        emit(SubscribePackageSuccess());
      });
    } on DioException catch (n) {
      emit(SubscribePackageError());
      logError(n.toString());
      logError(n.response.toString());
    } catch (e) {
      emit(SubscribePackageError());
      logError(e.toString());
    }
  }

  Future renewSubscribePackage({
    required int packageId,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(SubscribePackageLoading());
      await DioHelper.postData(url: EndPoints.epRenewHealthPackage, body: {
        "health_package_id": packageId,
      }).then((value) {
        if (value.data['message'] != null) {
          showToast(
            value.data['message'].replaceAll("api.", ""),
            ToastState.success,
          );
        }
        logSuccess(
            "PackageCubit renewSubscribePackage Response: ${value.data}");
        afterSuccess();
        emit(SubscribePackageSuccess());
      });
    } on DioException catch (n) {
      emit(SubscribePackageError());
      logError(n.toString());
    } catch (e) {
      emit(SubscribePackageError());
      logError(e.toString());
    }
  }

  Future upgradeSubscription({
    required int packageId,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(SubscribePackageLoading());
      await DioHelper.postData(url: EndPoints.epUpgradeHealthPackage, body: {
        "health_package_id": packageId,
      }).then((value) {
        if (value.data['message'] != null) {
          showToast(
            value.data['message'].replaceAll("api.", ""),
            ToastState.success,
          );
        }
        logSuccess("PackageCubit upgradeSubscription Response: ${value.data}");
        afterSuccess();
        emit(SubscribePackageSuccess());
      });
    } on DioException catch (n) {
      emit(SubscribePackageError());
      logError(n.toString());
    } catch (e) {
      emit(SubscribePackageError());
      logError(e.toString());
    }
  }
}
