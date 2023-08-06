import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/member_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class MemberService {
  final title = "MemberService";

  Future<MemberServiceResponse?> listMember(
    String province,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer: ${window.sessionStorage["token"]}',
    // };
    Map<String, String> qParams = {
      "offset": "0",
      "limit": "20",
      "order": "created_at",
      "province": province,
    };
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.member,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      MemberServiceResponse memberServiceResponse =
          MemberServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("memberServiceResponse $memberServiceResponse");
      return memberServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
