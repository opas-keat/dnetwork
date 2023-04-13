import 'package:get/get.dart';

import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/commiss/addCommiss/bindings/add_commiss_binding.dart';
import '../modules/commiss/addCommiss/views/add_commiss_view.dart';
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
import '../modules/report_problem/bindings/reportproblem_binding.dart';
import '../modules/report_problem/views/reportproblem_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/station/addStation/views/add_station_view.dart';
import '../modules/station/bindings/station_binding.dart';
import '../modules/station/views/station_view.dart';
import '../modules/villagehosty/bindings/villagehosty_binding.dart';
import '../modules/villagehosty/views/villagehosty_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGNIN;

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
          name: _Paths.ADD_STATION,
          page: () => AddStationView(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.COMMISS,
      page: () => CommissView(),
      binding: CommissBinding(),
      children: [
        GetPage(
          name: _Paths.ADD_COMMISS,
          page: () => AddCommissView(),
          binding: AddCommissBinding(),
        ),
      ],
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
  ];
}
