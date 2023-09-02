import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';

import '../../data/requests/station_service_request.dart';
import '../../data/responses/delete_service_response.dart';
import '../../data/responses/station_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_params.dart';
import '../api_utils.dart';

class StationService {
  final title = "StationService";

  Future<StationServiceResponse?> create(
    List<Stations> listStations,
  ) async {
    apiUtils.secureHeaders = {
      'Authorization': 'Bearer ${window.sessionStorage["token"]}',
    };
    talker.debug(StationServiceRequest(stations: listStations).toJson());
    try {
      final response = await apiUtils.post(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.station,
        data: StationServiceRequest(stations: listStations),
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      StationServiceResponse stationServiceResponse =
          StationServiceResponse.fromJson(jsonDecode(response.toString()));
      talker.debug('code:: ${stationServiceResponse.code}');
      if (stationServiceResponse.code == "000") {
        return StationServiceResponse(
          code: stationServiceResponse.code,
          message: response.data["message"],
          data: stationServiceResponse.data,
        );
      }
      return StationServiceResponse.withError(
          code: codeResponseNull, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return StationServiceResponse.withError(
          code: codeError, msg: apiUtils.handleError(e));
    }
  }

  Future<StationServiceResponse?> update(
    List<Stations> listStations,
  ) async {
    talker.debug(StationServiceRequest(stations: listStations).toJson());
    try {
      final response = await apiUtils.put(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.station,
        data: StationServiceRequest(stations: listStations),
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      StationServiceResponse stationServiceResponse =
          StationServiceResponse.fromJson(jsonDecode(response.toString()));
      talker.debug('code:: ${stationServiceResponse.code}');
      if (stationServiceResponse.code == "000") {
        return StationServiceResponse(
          code: stationServiceResponse.code,
          message: response.data["message"],
          data: stationServiceResponse.data,
        );
      }
      return StationServiceResponse.withError(
          code: codeResponseNull, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return StationServiceResponse.withError(
          code: codeError, msg: apiUtils.handleError(e));
    }
  }

  Future<DeleteServiceResponse?> delete(
    int id,
  ) async {
    try {
      final response = await apiUtils.delete(
        url:
            "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.station}/$id",
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

  Future<StationServiceResponse?> getById(
    int id,
  ) async {
    try {
      final response = await apiUtils.get(
        url:
            "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.station}/$id",
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      StationServiceResponse stationServiceResponse =
          StationServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("stationServiceResponse $stationServiceResponse");
      return stationServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }

  Future<StationServiceResponse?> list(
    Map<String, String> qParams,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer: ${window.sessionStorage["token"]}',
    // };
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.station,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      StationServiceResponse stationServiceResponse =
          StationServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("stationServiceResponse $stationServiceResponse");
      return stationServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
