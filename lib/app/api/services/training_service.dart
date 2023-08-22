import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/requests/training_service_request.dart';
import '../../data/responses/delete_service_response.dart';
import '../../data/responses/training_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_params.dart';
import '../api_utils.dart';

class TrainingService {
  final title = "TrainingService";

  Future<TrainingServiceResponse?> create(
    List<Trainings> listTrainings,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer ${window.sessionStorage["token"]}',
    // };
    talker.debug(TrainingServiceRequest(trainings: listTrainings).toJson());
    try {
      final response = await apiUtils.post(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.training,
        data: TrainingServiceRequest(trainings: listTrainings),
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      TrainingServiceResponse trainingServiceResponse =
          TrainingServiceResponse.fromJson(jsonDecode(response.toString()));
      talker.debug('code:: ${trainingServiceResponse.code}');
      if (trainingServiceResponse.code == "000") {
        return TrainingServiceResponse(
          code: trainingServiceResponse.code,
          message: response.data["message"],
          data: trainingServiceResponse.data,
        );
      }
      return TrainingServiceResponse.withError(
          code: CODE_RESPONSE_NULL, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return TrainingServiceResponse.withError(
          code: CODE_ERROR, msg: apiUtils.handleError(e));
    }
  }

  Future<TrainingServiceResponse?> update(
    List<Trainings> listTrainings,
  ) async {
    talker.debug(TrainingServiceRequest(trainings: listTrainings).toJson());
    try {
      final response = await apiUtils.put(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.training,
        data: TrainingServiceRequest(trainings: listTrainings),
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      TrainingServiceResponse trainingServiceResponse =
          TrainingServiceResponse.fromJson(jsonDecode(response.toString()));
      talker.debug('code:: ${trainingServiceResponse.code}');
      if (trainingServiceResponse.code == "000") {
        return TrainingServiceResponse(
          code: trainingServiceResponse.code,
          message: response.data["message"],
          data: trainingServiceResponse.data,
        );
      }
      return TrainingServiceResponse.withError(
          code: CODE_RESPONSE_NULL, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return TrainingServiceResponse.withError(
          code: CODE_ERROR, msg: apiUtils.handleError(e));
    }
  }

  Future<DeleteServiceResponse?> delete(
    int id,
  ) async {
    try {
      final response = await apiUtils.delete(
        url:
            "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.training}/$id",
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      DeleteServiceResponse deleteServiceResponse =
          DeleteServiceResponse.fromJson(jsonDecode(response.toString()));
      return deleteServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }

  Future<TrainingServiceResponse?> getById(
    int id,
  ) async {
    try {
      final response = await apiUtils.get(
        url:
            "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.training}/$id",
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      TrainingServiceResponse trainingServiceResponse =
          TrainingServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("trainingServiceResponse $trainingServiceResponse");
      return trainingServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }

  Future<TrainingServiceResponse?> list(
    Map<String, String> qParams,
  ) async {
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.training,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      TrainingServiceResponse trainingServiceResponse =
          TrainingServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("trainingServiceResponse $trainingServiceResponse");
      return trainingServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
