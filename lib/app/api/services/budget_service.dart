import 'dart:convert';

import 'package:dio/dio.dart';
import '../../data/requests/budget_service_request.dart';
import '../../data/responses/budget_service_response.dart';
import '../../data/responses/delete_service_response.dart';
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
          code: codeResponseNull, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return BudgetServiceResponse.withError(
          code: codeError, msg: apiUtils.handleError(e));
    }
  }

  Future<BudgetServiceResponse?> updateBudget(
    List<Budgets> listBudgets,
  ) async {
    talker.debug(BudgetServiceRequest(budgets: listBudgets).toJson());
    try {
      final response = await apiUtils.put(
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
          code: codeResponseNull, msg: response.data["message"]);
    } catch (e) {
      talker.error(e);
      return BudgetServiceResponse.withError(
          code: codeError, msg: apiUtils.handleError(e));
    }
  }

  Future<DeleteServiceResponse?> delete(
    int id,
  ) async {
    try {
      final response = await apiUtils.delete(
        url:
            "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.budget}/$id",
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

  Future<BudgetServiceResponse?> getById(
    int id,
  ) async {
    try {
      final response = await apiUtils.get(
        url:
            "${Api.ectApiContext}${Api.ectApiVersion}${ApiEndPoints.budget}/$id",
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

  Future<BudgetServiceResponse?> listBudget(
    Map<String, String> qParams,
  ) async {
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
