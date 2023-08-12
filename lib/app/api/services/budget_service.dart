import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';
import '../../data/requests/budget_service_request.dart';
import '../../data/responses/budget_service_response.dart';
import '../../shared/utils.dart';
import '../api.dart';
import '../api_end_points.dart';
import '../api_params.dart';
import '../api_utils.dart';

class BudgetService {
  final title = "BudgetService";

  Future<BudgetServiceResponse?> createBudget(
    List<Budgets> listBudgets,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer ${window.sessionStorage["token"]}',
    // };
    talker.debug(BudgetServiceRequest(budgets: listBudgets).toJson());
    try {
      final response = await apiUtils.post(
        url: Api.ectApiContext + Api.ectApiVersion + ApiEndPoints.budget,
        data: BudgetServiceRequest(budgets: listBudgets),
        options: Options(
          headers: apiUtils.secureHeaders,
        ),
      );
      BudgetServiceResponse budgetServiceResponse =
          BudgetServiceResponse.fromJson(jsonDecode(response.toString()));
      talker.debug('code:: ${budgetServiceResponse.code}');
      if (budgetServiceResponse.code == "000") {
        return BudgetServiceResponse(
          code: budgetServiceResponse.code,
          message: response.data["message"],
          data: budgetServiceResponse.data,
        );
      }
      return BudgetServiceResponse.withError(
          code: CODE_RESPONSE_NULL, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return BudgetServiceResponse.withError(
          code: CODE_ERROR, msg: apiUtils.handleError(e));
    }
  }

  Future<BudgetServiceResponse?> listBudget(
    String province,
    String budgetDate,
    String budgetType,
  ) async {
    // apiUtils.secureHeaders = {
    //   'Authorization': 'Bearer ${window.sessionStorage["token"]}',
    // };
    Map<String, String> qParams = {
      "offset": "0",
      "limit": queryParamLimit,
      "order": queryParamOrderBy,
      "budget_date": budgetDate,
      "budget_type": budgetType,
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
