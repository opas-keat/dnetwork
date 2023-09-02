import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/requests/incident_service_request.dart';
import '../../data/responses/delete_service_response.dart';
import '../../data/responses/incident_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_params.dart';
import '../api_utils.dart';

class IncidentService {
  final title = "IncidentService";

  Future<IncidentServiceResponse?> create(
    List<Incidents> listIncidents,
  ) async {
    talker.debug(IncidentServiceRequest(incidents: listIncidents).toJson());
    try {
      final response = await apiUtils.post(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.incident,
        data: IncidentServiceRequest(incidents: listIncidents),
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      IncidentServiceResponse incidentServiceResponse =
          IncidentServiceResponse.fromJson(jsonDecode(response.toString()));
      talker.debug('code:: ${incidentServiceResponse.code}');
      if (incidentServiceResponse.code == "000") {
        return IncidentServiceResponse(
          code: incidentServiceResponse.code,
          message: response.data["message"],
          data: incidentServiceResponse.data,
        );
      }
      return IncidentServiceResponse.withError(
          code: codeResponseNull, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return IncidentServiceResponse.withError(
          code: codeError, msg: apiUtils.handleError(e));
    }
  }

  Future<IncidentServiceResponse?> update(
    List<Incidents> listIncidents,
  ) async {
    talker.debug(IncidentServiceRequest(incidents: listIncidents).toJson());
    try {
      final response = await apiUtils.put(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.incident,
        data: IncidentServiceRequest(incidents: listIncidents),
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      IncidentServiceResponse incidentServiceResponse =
          IncidentServiceResponse.fromJson(jsonDecode(response.toString()));
      talker.debug('code:: ${incidentServiceResponse.code}');
      if (incidentServiceResponse.code == "000") {
        return IncidentServiceResponse(
          code: incidentServiceResponse.code,
          message: response.data["message"],
          data: incidentServiceResponse.data,
        );
      }
      return IncidentServiceResponse.withError(
          code: codeResponseNull, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return IncidentServiceResponse.withError(
          code: codeError, msg: apiUtils.handleError(e));
    }
  }

  Future<DeleteServiceResponse?> delete(
    int id,
  ) async {
    try {
      final response = await apiUtils.delete(
        url:
            "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.incident}/$id",
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

  Future<IncidentServiceResponse?> getById(
    int id,
  ) async {
    try {
      final response = await apiUtils.get(
        url:
            "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.incident}/$id",
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      IncidentServiceResponse incidentServiceResponse =
          IncidentServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("incidentServiceResponse $incidentServiceResponse");
      return incidentServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }

  Future<IncidentServiceResponse?> list(
    Map<String, String> qParams,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer: ${window.sessionStorage["token"]}',
    // };
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.incident,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      IncidentServiceResponse incidentServiceResponse =
          IncidentServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("incidentServiceResponse $incidentServiceResponse");
      return incidentServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
