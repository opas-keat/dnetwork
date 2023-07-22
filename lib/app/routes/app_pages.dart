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
import '../modules/station/detailStation/bindings/detail_station_binding.dart';
import '../modules/station/detailStation/views/detail_station_view.dart';
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
import 'app_middleware.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGNIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
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
      page: () => const DashboardView(),
      binding: DashboardBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: _Paths.STATION,
      page: () => StationView(),
      binding: StationBinding(),
      middlewares: [RouteGuard()],
      children: [
        GetPage(
          name: _Paths.MANAGE_STATION,
          page: () => ManageStationView(),
          binding: ManageStationBinding(),
          middlewares: [RouteGuard()],
        ),
        GetPage(
          name: _Paths.DETAIL_STATION,
          page: () => DetailStationView(),
          binding: DetailStationBinding(),
          middlewares: [RouteGuard()],
        ),
      ],
    ),
    GetPage(
      name: _Paths.COMMISS,
      page: () => CommissView(),
      binding: CommissBinding(),
      middlewares: [RouteGuard()],
      children: [
        GetPage(
          name: _Paths.MANAGE_COMMISS,
          page: () => ManageCommissView(),
          binding: ManageCommissBinding(),
          middlewares: [RouteGuard()],
        ),
      ],
    ),
    GetPage(
      name: _Paths.LECTUTER,
      page: () => LectuterView(),
      binding: LectuterBinding(),
      middlewares: [RouteGuard()],
      children: [
        GetPage(
          name: _Paths.MANAGE_LECTUTER,
          page: () => ManageLectuterView(),
          binding: ManageLectuterBinding(),
          middlewares: [RouteGuard()],
        ),
      ],
    ),
    GetPage(
      name: _Paths.VILLAGEHOSTY,
      page: () => VillagehostyView(),
      binding: VillagehostyBinding(),
      middlewares: [RouteGuard()],
      children: [
        GetPage(
          name: _Paths.MANAGE_VILLAGE,
          page: () => ManageVillageView(),
          binding: ManageVillageBinding(),
          middlewares: [RouteGuard()],
        ),
      ],
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: _Paths.REPORTPROBLEM,
      page: () => ReportproblemView(),
      binding: ReportproblemBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: _Paths.LIST_REPORT,
      page: () => ListReportView(),
      binding: ListReportBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: _Paths.NEW_HOME,
      page: () => const NewHomeView(),
      binding: NewHomeBinding(),
      middlewares: [RouteGuard()],
      children: [
        GetPage(
          name: _Paths.ADD_DATA,
          page: () => const AddDataView(),
          binding: AddDataBinding(),
          middlewares: [RouteGuard()],
        ),
      ],
    ),
    GetPage(
      name: _Paths.MEMBER,
      page: () => const MemberView(),
      binding: MemberBinding(),
      middlewares: [RouteGuard()],
      children: [
        GetPage(
          name: _Paths.MANAGE_MEMBER,
          page: () => ManageMemberView(),
          binding: ManageMemberBinding(),
          middlewares: [RouteGuard()],
        ),
      ],
    ),
    GetPage(
      name: _Paths.NETWORK,
      page: () => const NetworkView(),
      binding: NetworkBinding(),
      middlewares: [RouteGuard()],
      children: [
        GetPage(
          name: _Paths.MANAGE_NETWORK,
          page: () => ManageNetworkView(),
          binding: ManageNetworkBinding(),
          middlewares: [RouteGuard()],
        ),
      ],
    ),
    GetPage(
      name: _Paths.TRAINING,
      page: () => const TrainingView(),
      binding: TrainingBinding(),
      middlewares: [RouteGuard()],
      children: [
        GetPage(
          name: _Paths.MANAGE_TRAINING,
          page: () => ManageTrainingView(),
          binding: ManageTrainingBinding(),
          middlewares: [RouteGuard()],
        ),
      ],
    ),
    GetPage(
      name: _Paths.BUDGET,
      page: () => const BudgetView(),
      binding: BudgetBinding(),
      middlewares: [RouteGuard()],
      children: [
        GetPage(
          name: _Paths.MANAGE_BUDGET,
          page: () => ManageBudgetView(),
          binding: ManageBudgetBinding(),
          middlewares: [RouteGuard()],
        ),
      ],
    ),
  ];
}
