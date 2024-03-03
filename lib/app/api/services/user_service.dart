import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/user_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class UserService {
  final title = "UserService";

  // Future<UserServiceResponse?> create(
  //   List<Users> listUsers,
  // ) async {
  //   talker.debug(UserServiceRequest(users: listUsers).toJson());
  //   try {
  //     final response = await apiUtils.post(
  //       url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.user,
  //       data: UserServiceRequest(users: listUsers),
  //       options: Options(
  //         headers: apiUtils.secureHeaders,
  //       ),
  //     );
  //     UserServiceResponse userServiceResponse =
  //         UserServiceResponse.fromJson(jsonDecode(response.toString()));
  //     talker.debug('code:: ${userServiceResponse.code}');
  //     if (userServiceResponse.code == "000") {
  //       return UserServiceResponse(
  //         code: userServiceResponse.code,
  //         message: response.data["message"],
  //         data: userServiceResponse.data,
  //       );
  //     }
  //     return UserServiceResponse.withError(
  //         code: codeResponseNull, msg: response.data["message"]);
  //   } catch (e) {
  //     talker.error(e);
  //     return UserServiceResponse.withError(
  //         code: codeError, msg: apiUtils.handleError(e));
  //   }
  // }

  // Future<UserServiceResponse?> update(
  //   List<Users> listUsers,
  // ) async {
  //   talker.debug(UserServiceRequest(users: listUsers).toJson());
  //   try {
  //     final response = await apiUtils.put(
  //       url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.user,
  //       data: UserServiceRequest(users: listUsers),
  //       options: Options(
  //         headers: apiUtils.secureHeaders,
  //       ),
  //     );
  //     UserServiceResponse userServiceResponse =
  //         UserServiceResponse.fromJson(jsonDecode(response.toString()));
  //     talker.debug('code:: ${userServiceResponse.code}');
  //     if (userServiceResponse.code == "000") {
  //       return UserServiceResponse(
  //         code: userServiceResponse.code,
  //         message: response.data["message"],
  //         data: userServiceResponse.data,
  //       );
  //     }
  //     return UserServiceResponse.withError(
  //         code: codeResponseNull, msg: response.data["message"]);
  //   } catch (e) {
  //     talker.error(e);
  //     return UserServiceResponse.withError(
  //         code: codeError, msg: apiUtils.handleError(e));
  //   }
  // }

  // Future<DeleteServiceResponse?> delete(
  //   int id,
  // ) async {
  //   try {
  //     final response = await apiUtils.delete(
  //       url:
  //           "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.user}/$id",
  //       options: Options(
  //         headers: apiUtils.secureHeaders,
  //       ),
  //     );
  //     DeleteServiceResponse deleteServiceResponse =
  //         DeleteServiceResponse.fromJson(jsonDecode(response.toString()));
  //     return deleteServiceResponse;
  //   } catch (e) {
  //     talker.error(e);
  //   }
  //   return null;
  // }

  // Future<UserServiceResponse?> getById(
  //   int id,
  // ) async {
  //   try {
  //     final response = await apiUtils.get(
  //       url:
  //           "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.user}/$id",
  //       options: Options(
  //         headers: apiUtils.secureHeaders,
  //       ),
  //     );
  //     UserServiceResponse userServiceResponse =
  //         UserServiceResponse.fromJson(jsonDecode(response.toString()));
  //     // talker.debug("userServiceResponse $userServiceResponse");
  //     return userServiceResponse;
  //   } catch (e) {
  //     talker.error(e);
  //   }
  //   return null;
  // }

  // Future<UserServiceResponse?> list(
  //   Map<String, String> qParams,
  // ) async {
  //   // apiUtils.secureHeaders = {
  //   //   'Authorization': 'Bearer: ${window.sessionStorage["token"]}',
  //   // };
  //   try {
  //     final response = await apiUtils.get(
  //       url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.user,
  //       queryParameters: qParams,
  //       options: Options(
  //         headers: apiUtils.secureHeaders,
  //       ),
  //     );
  //     UserServiceResponse userServiceResponse =
  //         UserServiceResponse.fromJson(jsonDecode(response.toString()));
  //     // talker.debug("userServiceResponse $userServiceResponse");
  //     return userServiceResponse;
  //   } catch (e) {
  //     talker.error(e);
  //   }
  //   return null;
  // }

  Future<UserServiceResponse?> getByToken() async {
    try {
      final response = await apiUtils.get(
        url: "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.user}",
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      UserServiceResponse userServiceResponse =
          UserServiceResponse.fromJson(jsonDecode(response.toString()));
      return userServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }

  Future<bool> updatePdpa() async {
    try {
      final response = await apiUtils.put(
        url:
            "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.user}/pdpa",
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      // UserServiceResponse userServiceResponse =
      //     UserServiceResponse.fromJson(jsonDecode(response.toString()));
      return true;
    } catch (e) {
      talker.error(e);
      return true;
    }
  }
}
