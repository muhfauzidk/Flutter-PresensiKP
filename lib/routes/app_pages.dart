import 'package:absensi/Admin/Screens/admin_detail_users_screen.dart';
import 'package:absensi/Admin/Screens/admin_main_screen.dart';
import 'package:absensi/Admin/Screens/admin_presence_screen.dart';
import 'package:absensi/Admin/Screens/admin_users_data_screen.dart';
import 'package:absensi/Screens/account_setting_screen.dart';
import 'package:absensi/Screens/detail_presence_screen.dart';
import 'package:absensi/Screens/dashboard_screen.dart';
import 'package:absensi/Screens/forgot_password_view.dart';
import 'package:absensi/Screens/login_screen.dart';
import 'package:absensi/Screens/main_screen.dart';
import 'package:absensi/Screens/presence_screen.dart';
import 'package:absensi/Screens/profile_screen.dart';
import 'package:absensi/Screens/update_profile_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.MAIN,
      page: () => MainScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () => AdminMainScreen(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: _Paths.ADMIN_PRESENCE,
      page: () => AdminAllPresenceView(),
    ),
    GetPage(
      name: _Paths.USERS_DATA,
      page: () => UsersDataScreen(),
    ),
    GetPage(
      name: _Paths.DETAIL_USERS,
      page: () => DetailUsersScreen(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => profileScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_POFILE,
      page: () => UpdateProfileScreen(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRESENCE,
      page: () => DetailPresenceScreen(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => AccountSettingScreen(),
    ),
    GetPage(
      name: _Paths.ALL_PRESENCE,
      page: () => AllPresenceView(),
    ),
  ];
}
