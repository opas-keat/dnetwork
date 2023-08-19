import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/budget_type_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class BudgetTypeService {
  final title = "BudgetTypeService";

  Future<BudgetTypeServiceResponse?> list(
    Map<String, String> qParams,
  ) async {
    try {
      final response = await apiUtils.get(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.budgetType,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      BudgetTypeServiceResponse budgetTypeServiceResponse =
          BudgetTypeServiceResponse.fromJson(jsonDecode(response.toString()));
      return budgetTypeServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
