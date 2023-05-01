import 'package:get/get.dart';

import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/budget/bindings/budget_binding.dart';
import '../modules/budget/views/budget_view.dart';
import '../modules/commiss/bindings/commiss_binding.dart';
import '../modules/commiss/views/commiss_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/lectuter/bindings/lectuter_binding.dart';
import '../modules/lectuter/views/lectuter_view.dart';
import '../modules/list_report/bindings/list_report_binding.dart';
import '../modules/list_report/views/list_report_view.dart';
import '../modules/member/bindings/member_binding.dart';
import '../modules/member/views/member_view.dart';
import '../modules/network/bindings/network_binding.dart';
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
import '../modules/training/views/training_view.dart';
import '../modules/villagehosty/bindings/villagehosty_binding.dart';
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
    ),
    GetPage(
      name: _Paths.LECTUTER,
      page: () => LectuterView(),
      binding: LectuterBinding(),
    ),
    GetPage(
      name: _Paths.VILLAGEHOSTY,
      page: () => VillagehostyView(),
      binding: VillagehostyBinding(),
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
      page: () => const NewHomeView(),
      binding: NewHomeBinding(),
      children: [
        GetPage(
          name: _Paths.ADD_DATA,
          page: () => const AddDataView(),
          binding: AddDataBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.MEMBER,
      page: () => MemberView(),
      binding: MemberBinding(),
    ),
    GetPage(
      name: _Paths.NETWORK,
      page: () => NetworkView(),
      binding: NetworkBinding(),
    ),
    GetPage(
      name: _Paths.TRAINING,
      page: () => TrainingView(),
      binding: TrainingBinding(),
    ),
    GetPage(
      name: _Paths.BUDGET,
      page: () => BudgetView(),
      binding: BudgetBinding(),
    ),
  ];
}
