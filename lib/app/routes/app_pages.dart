import 'package:get/get.dart';

import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/commiss/bindings/commiss_binding.dart';
import '../modules/commiss/views/commiss_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/lectuter/bindings/lectuter_binding.dart';
import '../modules/lectuter/views/lectuter_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
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
      page: () => const StationView(),
      binding: StationBinding(),
    ),
    GetPage(
      name: _Paths.COMMISS,
      page: () => const CommissView(),
      binding: CommissBinding(),
    ),
    GetPage(
      name: _Paths.LECTUTER,
      page: () => const LectuterView(),
      binding: LectuterBinding(),
    ),
    GetPage(
      name: _Paths.VILLAGEHOSTY,
      page: () => const VillagehostyView(),
      binding: VillagehostyBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
  ];
}
