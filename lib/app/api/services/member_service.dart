import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';
import '../../data/requests/member_service_request.dart';
import '../../data/responses/member_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_params.dart';
import '../api_utils.dart';

class MemberService {
  final title = "MemberService";

  Future<MemberServiceResponse?> createMember(
    List<Members> listMembers,
  ) async {
    apiUtils.secureHeaders = {
      'Authorization': 'Bearer ${window.sessionStorage["token"]}',
    };
    talker.debug(MemberServiceRequest(members: listMembers).toJson());
    try {
      final response = await apiUtils.post(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.member,
        data: MemberServiceRequest(members: listMembers),
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      MemberServiceResponse memberServiceResponse =
          MemberServiceResponse.fromJson(jsonDecode(response.toString()));
      talker.debug('code:: ${memberServiceResponse.code}');
      if (memberServiceResponse.code == "000") {
        return MemberServiceResponse(
          code: memberServiceResponse.code,
          message: response.data["message"],
          data: memberServiceResponse.data,
        );
      }
      return MemberServiceResponse.withError(
          code: CODE_RESPONSE_NULL, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return MemberServiceResponse.withError(
          code: CODE_ERROR, msg: apiUtils.handleError(e));
    }
  }

  Future<MemberServiceResponse?> listMember(
    Map<String, String> qParams,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer: ${window.sessionStorage["token"]}',
    // };
    // Map<String, String> qParams = {
    //   "offset": "0",
    //   "limit": "20",
    //   "order": "created_at",
    //   "province": province,
    // };
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
