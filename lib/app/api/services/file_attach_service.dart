import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/file_attach_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class FileAttachService {
  final title = "FileAttachService";

  Future<FileAttachServiceResponse?> getProfiles(
    Map<String, String> qParams,
  ) async {
    try {
      final response = await apiUtils.get(
        url:
            "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.fileAttach}/profiles",
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      FileAttachServiceResponse fileAttachServiceResponse =
          FileAttachServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("fileAttachServiceResponse $fileAttachServiceResponse");
      return fileAttachServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
