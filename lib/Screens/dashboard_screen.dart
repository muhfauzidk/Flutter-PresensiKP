import 'package:absensi/Controller/absensi_controller.dart';
import 'package:absensi/Controller/home_controller.dart';
import 'package:absensi/Widgets/presence_card.dart';
import 'package:absensi/common/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class homeScreen extends GetView<HomeController> {
  static String routeName = "/dashboard";

  @override
  Widget build(BuildContext context) {
    final controller = HomeController();
    return Scaffold(
      extendBody: true,
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.done:
                Map<String, dynamic> user = snapshot.data!.data()!;
                return ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 36),
                  children: [
                    SizedBox(height: 16),
                    // Section 1 - Welcome Back
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          ClipOval(
                            child: Container(
                              width: 42,
                              height: 42,
                              child: Image.asset(
                                ('assets/images/avatar.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selamat Datang",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: secondarySoft,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                user["name"],
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'poppins',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // section 2 -  card
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: controller.streamTodayPresence(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.active:
                            case ConnectionState.done:
                              var todayPresenceData = snapshot.data?.data();
                              return PresenceCard(
                                userData: user,
                                todayPresenceData: todayPresenceData,
                              );
                            default:
                              return SizedBox();
                          }
                        }),
                    // last location
                    Container(
                        margin: EdgeInsets.only(top: 12, bottom: 24, left: 4),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(Icons.location_on_outlined)),
                              TextSpan(
                                text: (user["address"] != null)
                                    ? "${user['address']}"
                                    : "Belum ada lokasi",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: secondarySoft,
                                ),
                              ),
                            ],
                          ),
                        )),
                    //Menu activity
                    _MenuActivityComponent(),
                    SizedBox(
                      height: 20,
                    ),
                    // section 3 distance & map
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 84,
                              decoration: BoxDecoration(
                                color: primaryExtraSoft,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 6),
                                    child: Text(
                                      'Jarak kantor',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      '${controller.officeDistance.value}',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              onTap: controller.launchOfficeOnMap,
                              child: Container(
                                height: 84,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: primaryExtraSoft,
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/map.JPG'),
                                    fit: BoxFit.cover,
                                    opacity: 0.3,
                                  ),
                                ),
                                child: Text(
                                  'Open in maps',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );

              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                return Center(child: Text("Error"));
            }
          }),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}

class _MenuComponent extends StatelessWidget {
  final String? titleMenu;
  final String? iconPath;
  final VoidCallback? onTap;

  _MenuComponent({this.titleMenu, this.iconPath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: deviceWidth(context) - 1.5 * defaultMargin,
            height: 54,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titleMenu!,
                  style: boldWhiteFont.copyWith(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuActivityComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Menu Aktivitas",
          style: semiBlackFont.copyWith(fontSize: 14),
        ),
        SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 24,
          runSpacing: 20,
          children: [
            _MenuComponent(
              titleMenu: "Absen sekarang",
              onTap: () {
                PresenceController().presence();
              },
            ),
          ],
        ),
      ],
    );
  }
}
