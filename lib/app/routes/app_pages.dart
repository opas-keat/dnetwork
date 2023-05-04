import 'package:get/get.dart';

import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/budget/bindings/budget_binding.dart';
import '../modules/budget/manageBudget/bindings/manage_budget_binding.dart';
import '../modules/budget/manageBudget/views/manage_budget_view.dart';
import '../modules/budget/views/budget_view.dart';
import '../modules/commiss/bindings/commiss_binding.dart';
import '../modules/commiss/manageCommiss/bindings/manage_commiss_binding.dart';
import '../modules/commiss/manageCommiss/views/manage_commiss_view.dart';
import '../modules/commiss/views/commiss_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/lectuter/bindings/lectuter_binding.dart';
import '../modules/lectuter/manageLectuter/bindings/manage_lectuter_binding.dart';
import '../modules/lectuter/manageLectuter/views/manage_lectuter_view.dart';
import '../modules/lectuter/views/lectuter_view.dart';
import '../modules/list_report/bindings/list_report_binding.dart';
import '../modules/list_report/views/list_report_view.dart';
import '../modules/member/bindings/member_binding.dart';
import '../modules/member/manageMember/bindings/manage_member_binding.dart';
import '../modules/member/manageMember/views/manage_member_view.dart';
import '../modules/member/views/member_view.dart';
import '../modules/network/bindings/network_binding.dart';
import '../modules/network/manageNetwork/bindings/manage_network_binding.dart';
import '../modules/network/manageNetwork/views/manage_network_view.dart';
import '../modules/network/views/network_view.dart';
import '../modules/newHome/addData/bindings/add_data_binding.dart';
import '../modules/newHome/addData/views/add_data_view.dart';
import '../modules/newHome/bindings/new_home_binding.dart';
import '../modules/newHome/views/new_home_view.dart';
import '../modules/report_problem/bindings/reportproblem_binding.dart';
import '../modules/report_problem/views/reportproblem_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/station/bindings/station_binding.dart';
import '../modules/station/manageStation/bindings/manage_station_binding.dart';
import '../modules/station/manageStation/views/manage_station_view.dart';
import '../modules/station/views/station_view.dart';
import '../modules/training/bindings/training_binding.dart';
import '../modules/training/manageTraining/bindings/manage_training_binding.dart';
import '../modules/training/manageTraining/views/manage_training_view.dart';
import '../modules/training/views/training_view.dart';
import '../modules/villagehosty/bindings/villagehosty_binding.dart';
import '../modules/villagehosty/manageVillage/bindings/manage_village_binding.dart';
import '../modules/villagehosty/manageVillage/views/manage_village_view.dart';
import '../modules/villagehosty/views/villagehosty_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () => AdminView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.STATION,
      page: () => StationView(),
      binding: StationBinding(),
      children: [
        GetPage(
          name: _Paths.MANAGE_STATION,
          page: () => ManageStationView(),
          binding: ManageStationBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.COMMISS,
      page: () => CommissView(),
      binding: CommissBinding(),
      children: [
        GetPage(
          name: _Paths.MANAGE_COMMISS,
          page: () => ManageCommissView(),
          binding: ManageCommissBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LECTUTER,
      page: () => LectuterView(),
      binding: LectuterBinding(),
      children: [
        GetPage(
          name: _Paths.MANAGE_LECTUTER,
          page: () => ManageLectuterView(),
          binding: ManageLectuterBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.VILLAGEHOSTY,
      page: () => VillagehostyView(),
      binding: VillagehostyBinding(),
      children: [
        GetPage(
          name: _Paths.MANAGE_VILLAGE,
          page: () => ManageVillageView(),
          binding: ManageVillageBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.REPORTPROBLEM,
      page: () => ReportproblemView(),
      binding: ReportproblemBinding(),
    ),
    GetPage(
      name: _Paths.LIST_REPORT,
      page: () => ListReportView(),
      binding: ListReportBinding(),
    ),
    GetPage(
      name: _Paths.NEW_HOME,
      page: () => NewHomeView(),
      binding: NewHomeBinding(),
      children: [
        GetPage(
          name: _Paths.ADD_DATA,
          page: () => AddDataView(),
          binding: AddDataBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.MEMBER,
      page: () => MemberView(),
      binding: MemberBinding(),
      children: [
        GetPage(
          name: _Paths.MANAGE_MEMBER,
          page: () => ManageMemberView(),
          binding: ManageMemberBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.NETWORK,
      page: () => NetworkView(),
      binding: NetworkBinding(),
      children: [
        GetPage(
          name: _Paths.MANAGE_NETWORK,
          page: () => ManageNetworkView(),
          binding: ManageNetworkBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.TRAINING,
      page: () => TrainingView(),
      binding: TrainingBinding(),
      children: [
        GetPage(
          name: _Paths.MANAGE_TRAINING,
          page: () => ManageTrainingView(),
          binding: ManageTrainingBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.BUDGET,
      page: () => BudgetView(),
      binding: BudgetBinding(),
      children: [
        GetPage(
          name: _Paths.MANAGE_BUDGET,
          page: () => ManageBudgetView(),
          binding: ManageBudgetBinding(),
        ),
      ],
    ),
  ];
}
