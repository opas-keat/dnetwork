import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/responses/budget_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_utils.dart';

class BudgetService {
  final title = "BudgetService";

  Future<BudgetServiceResponse?> listBudget(
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
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.budget,
        queryParameters: qParams,
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      BudgetServiceResponse budgetServiceResponse =
          BudgetServiceResponse.fromJson(jsonDecode(response.toString()));
      // talker.debug("budgetServiceResponse $budgetServiceResponse");
      return budgetServiceResponse;
    } catch (e) {
      talker.error(e);
    }
    return null;
  }
}
