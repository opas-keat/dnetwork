import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import '../../data/responses/file_attach_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_params.dart';
import '../api_utils.dart';

class FileAttachService {
  final title = "FileAttachService";

  Future<FileAttachServiceResponse?> create(
    String fileName,
    int fileSize,
    Uint8List bytes,
    String module,
    String linkType,
    String? linkId,
  ) async {
    try {
      var formData = FormData.fromMap({
        'id': 0,
        'file_name': fileName,
        'file_size': fileSize,
        'module': module,
        'link_type': linkType,
        'link_id': linkId,
        'file': MultipartFile.fromBytes(
          bytes,
          filename: fileName,
        ),
      });
      final response = await apiUtils.post(
        url:
            "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.fileAttach}",
        data: formData,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      FileAttachServiceResponse fileServiceResponse =
          FileAttachServiceResponse.fromJson(jsonDecode(response.toString()));
      talker.debug('code:: ${fileServiceResponse.code}');
      if (fileServiceResponse.code == "000") {
        return FileAttachServiceResponse(
          code: fileServiceResponse.code,
          message: response.data["message"],
          data: fileServiceResponse.data,
        );
      }
      return FileAttachServiceResponse.withError(
          code: codeResponseNull, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return FileAttachServiceResponse.withError(
          code: codeError, msg: apiUtils.handleError(e));
    }
  }

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
