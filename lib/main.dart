// @dart=2.9

import 'package:absensi/provider/history_provider.dart';
import 'package:absensi/provider/user_provider.dart';
import 'package:absensi/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:absensi/utils/route_utils.dart';
import 'package:absensi/common/common.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('id_ID', null).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ],
        child: GetMaterialApp(
          title: "Absensi",
          home: splashScreen(),
          theme: appTheme,
          routes: routes,
          initialRoute: "/",
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
