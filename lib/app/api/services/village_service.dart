import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';
import '../../data/requests/village_service_request.dart';
import '../../data/responses/village_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_params.dart';
import '../api_utils.dart';

class VillageService {
  final title = "VillageService";

  Future<VillageServiceResponse?> createVillage(
    List<Villages> listVillages,
  ) async {
    apiUtils.secureHeaders = {
      'Authorization': 'Bearer ${window.sessionStorage["token"]}',
    };
    talker.debug(VillageServiceRequest(villages: listVillages).toJson());
    try {
      final response = await apiUtils.post(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.village,
        data: VillageServiceRequest(villages: listVillages),
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      VillageServiceResponse villageServiceResponse =
          VillageServiceResponse.fromJson(jsonDecode(response.toString()));
      talker.debug('code:: ${villageServiceResponse.code}');
      if (villageServiceResponse.code == "000") {
        return VillageServiceResponse(
          code: villageServiceResponse.code,
          message: response.data["message"],
          data: villageServiceResponse.data,
        );
      }
      return VillageServiceResponse.withError(
          code: CODE_RESPONSE_NULL, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return VillageServiceResponse.withError(
          code: CODE_ERROR, msg: apiUtils.handleError(e));
    }
  }

  Future<VillageServiceResponse?> listVillage(
    Map<String, String> qParams,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer: ${window.sessionStorage["token"]}',
    // };
    
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.village,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      VillageServiceResponse villageServiceResponse =
          VillageServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("commissServiceResponse $commissServiceResponse");
      return villageServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
