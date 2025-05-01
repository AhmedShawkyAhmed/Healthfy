import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthify/src/constants/const_methods.dart';
import 'package:healthify/src/data/response/points_response/points_response.dart';
import 'package:healthify/src/data/shared_models/points_model.dart';

import '../../constants/end_points.dart';
import '../../services/dio_helper.dart';

part 'points_state.dart';

class PointsCubit extends Cubit<PointsState> {
  PointsCubit() : super(PointsInitial());

  static PointsCubit get(context) => BlocProvider.of(context);

  PointsModel? _pointsModel;

  PointsModel? get pointsModel => _pointsModel;

  Future getPoints() async {
    try {
      emit(GetPointsLoading());
      final response = await DioHelper.getData(
        url: EndPoints.epGetUserPointData,
      );
      logSuccess("PointsCubit getPoints Response: $response");
      final model = PointsResponse.fromJson(response.data);
      if (model.data?.points != null) {
        _pointsModel = model.data!.points!;
      }
      emit(GetPointsSuccess());
    } on DioException catch (dioError) {
      logError("PointsCubit getPoints Response Error: ${dioError.response}");
      (dioError.response?.data["message"].toString().replaceAll("api.", "") ??
              "Server Error!")
          .toToastError();
      emit(GetPointsError());
    } catch (e) {
      logError("PointsCubit getPoints Error: $e");
      "Unknown Error!".toToastError();
      emit(GetPointsError());
    }
  }
}
