import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/constants/end_points.dart';
import 'package:healthify/src/data/models/medicine_type_doctors_model.dart';
import 'package:healthify/src/data/request/medicine_type_request.dart';
import 'package:healthify/src/data/request/search_medicine_type_request.dart';
import 'package:healthify/src/data/response/medecine_type_response/medicine_type_response.dart';
import 'package:healthify/src/data/response/medicine_type_category_response/medicine_type_category_response.dart';
import 'package:healthify/src/data/response/search_medicine_type_response/search_medicine_type_response.dart';
import 'package:healthify/src/data/response/specialisties_response/specialisties_response.dart';
import 'package:healthify/src/data/shared_models/medicine_type_model.dart';
import 'package:healthify/src/data/shared_models/specialty_model.dart';
import 'package:healthify/src/services/dio_helper.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/models/category_model.dart';

part 'medicine_type_state.dart';

class MedicineTypeCubit extends Cubit<MedicineTypeState> {
  MedicineTypeCubit() : super(MedicineTypeInitial());

  static MedicineTypeCubit get(BuildContext context) =>
      BlocProvider.of(context);
  MedicineTypeCategoriesResponse? medicineTypeCategoriesResponse;
  var _medicineTypeCategories = <CategoryModel>[];

  List<CategoryModel> get medicineTypeCategories => _medicineTypeCategories;

  Future getMedicineTypeCategories() async {
    try {
      emit(MedicineTypeGetCategoriesLoadingState());
      final dir = await getTemporaryDirectory();
      CacheStore cacheStore = HiveCacheStore(dir.path);
      var cacheOptions = CacheOptions(
        store: cacheStore,
        hitCacheOnErrorExcept: [], // for offline behaviour
      );
      var interceptor = DioCacheInterceptor(options: cacheOptions);
      final response = await DioHelper.getData(
        url: EndPoints.epGetMedicineTypeCat,
        interceptor: interceptor,
      );
      DioHelper.dio.interceptors.removeLast();
      logSuccess(
          "MedicineTypeCubit getMedicineTypeCategories Response: $response");
      medicineTypeCategoriesResponse =
          MedicineTypeCategoriesResponse.fromJson(response.data);

      _medicineTypeCategories = medicineTypeCategoriesResponse!.data!.types!;
      emit(MedicineTypeGetCategoriesSuccessState());
    } on DioException catch (dioError) {
      logError(
          "MedicineTypeCubit getMedicineTypeCategories Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(MedicineTypeGetCategoriesFailureState());
    } catch (error) {
      logError("MedicineTypeCubit getMedicineTypeCategories Error: $error");
      "Unknown Error!".toToastError();
      emit(MedicineTypeGetCategoriesFailureState());
    }
  }

  final _mostChosenSpecialties = <SpecialtyModel>[];
  final _otherSpecialties = <SpecialtyModel>[];

  List<SpecialtyModel> get mostChosenSpecialities => _mostChosenSpecialties;

  List<SpecialtyModel> get otherSpecialties => _otherSpecialties;

  Future getSpecialties() async {
    try {
      emit(MedicineTypeGetSpecialtiesLoadingState());
      final response = await DioHelper.getData(
        url: EndPoints.epGetSpecialties,
      );
      logSuccess("MedicineTypeCubit getSpecialties Response: $response");
      final model = SpecialistiesResponse.fromJson(response.data);
      if (model.data?.otherSpecialties != null) {
        _otherSpecialties.clear();
        _otherSpecialties.addAll(model.data!.otherSpecialties!);
      }
      if (model.data?.mostChosenSpecialties != null) {
        _mostChosenSpecialties.clear();
        _mostChosenSpecialties.addAll(model.data!.mostChosenSpecialties!);
      }
      emit(MedicineTypeGetSpecialtiesSuccessState());
    } on DioException catch (dioError) {
      logError(
          "MedicineTypeCubit getSpecialties Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(MedicineTypeGetSpecialtiesFailureState());
    } catch (error) {
      logError("MedicineTypeCubit getSpecialties Error: $error");
      "Unknown Error!".toToastError();
      emit(MedicineTypeGetSpecialtiesFailureState());
    }
  }

  final _medicineTypes = <MedicineTypeModel>[];

  List<MedicineTypeModel> get medicineTypes => _medicineTypes;

  final _medicineTypeDoctors = <MedicineTypeDoctorsModel>[];

  List<MedicineTypeDoctorsModel> get medicineTypeDoctors =>
      _medicineTypeDoctors;

  updateMedicineTypeFav(num id, bool value) {
    final index = medicineTypes.indexWhere(
      (element) => element.id == id,
    );
    if (index != -1) {
      _medicineTypes[index].fav = value;
      _selectedModel?.fav = value;
      emit(MedicineTypeUpdateFavState());
    }
  }

  MedicineTypeModel? _selectedModel;

  MedicineTypeModel? get selectedModel => _selectedModel;

  void updateSelectedModel(MedicineTypeModel selectedModel) {
    _selectedModel = selectedModel;
    emit(MedicineTypeUpdateSelectedModelState());
  }

  List<int> discounts = [0];

  Future getMedicineType({required MedicineTypeRequest request}) async {
    logWarning(request.toJson().toString());
    try {
      emit(MedicineTypeGetTypesLoadingState());
      _medicineTypes.clear();
      final response = await DioHelper.postData(
        url: EndPoints.epGetMedicineType,
        body: request.toJson(),
      );
      logSuccess("MedicineTypeCubit getMedicineType Response: $response");
      final model = MedicineTypeResponse.fromJson(response.data);
      if (model.data?.medicineType != null) {
        _medicineTypes.addAll(model.data!.medicineType!);
        if (model.data!.medicineType!.isNotEmpty &&
            model.data!.medicineType![0].normalDiscount != null) {
          for (int i = 0; i < model.data!.medicineType!.length; i++) {
            discounts
                .add(model.data!.medicineType![i].normalDiscount?.toInt() ?? 0);
          }
        }
      }
      if (model.data?.doctors != null) {
        _medicineTypeDoctors.clear();
        _medicineTypeDoctors.addAll(model.data!.doctors!);
      }
      emit(MedicineTypeGetTypesSuccessState());
    } on DioException catch (dioError) {
      logError(
          "MedicineTypeCubit getMedicineType Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(MedicineTypeGetTypesFailureState());
    } catch (error) {
      logError("MedicineTypeCubit getMedicineType Error: $error");
      "Unknown Error!".toToastError();
      emit(MedicineTypeGetTypesFailureState());
    }
  }

  Future searchMedicineType({
    required SearchMedicineTypeRequest request,
  }) async {
    try {
      logSuccess(request.toJson().toString());
      emit(MedicineTypeSearchTypesLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epSearchMedicineType,
        body: request.toJson(),
      );
      logSuccess("MedicineTypeCubit searchMedicineType Response: $response");
      final model = SearchMedicineTypeResponse.fromJson(response.data);
      if (request.page == 1) {
        _medicineTypes.clear();
      }
      if (model.data?.media != null) {
        _medicineTypes.addAll(model.data!.media!);
      }
      emit(
        MedicineTypeSearchTypesSuccessState(
          model.data?.media?.isEmpty == true,
        ),
      );
    } on DioException catch (dioError) {
      logError(
          "MedicineTypeCubit searchMedicineType Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(MedicineTypeSearchTypesFailureState());
    } catch (error) {
      logError("MedicineTypeCubit searchMedicineType Error: $error");
      "Unknown Error!".toToastError();
      emit(MedicineTypeSearchTypesFailureState());
    }
  }

  Future increaseSpecialityFrequency({required num specialtyId}) async {
    try {
      logSuccess("Specialty Id: $specialtyId");
      emit(MedicineTypeIncreaseSpecialtyFrequencyLoadingState());
      final response = await DioHelper.postData(
        url: EndPoints.epIncreaseSpecialityFrequency,
        body: {
          "speciality_id": specialtyId,
        },
      );
      logSuccess(
          "MedicineTypeCubit increaseSpecialityFrequency Response: $response");
      emit(MedicineTypeIncreaseSpecialtyFrequencySuccessState());
    } on DioException catch (error) {
      logError(
          "MedicineTypeCubit increaseSpecialityFrequency Response Error: $error");
      emit(MedicineIncreaseSpecialtyFrequencyFailureState());
    } catch (error) {
      logError("MedicineTypeCubit increaseSpecialityFrequency Error: $error");
      emit(MedicineIncreaseSpecialtyFrequencyFailureState());
    }
  }
}
