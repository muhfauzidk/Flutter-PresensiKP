import 'package:absensi/Model/user_model.dart';
import 'package:absensi/Screens/account_setting_screen.dart';
import 'package:absensi/Screens/login_screen.dart';
import 'package:absensi/Screens/update_profile_view.dart';
import 'package:absensi/common/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class profileScreen extends StatefulWidget {
  static String routeName = "/profile_screen";
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 36),
        children: [
          SizedBox(height: 16),
          // section 1 - profile
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  width: 124,
                  height: 124,
                  color: Colors.blue,
                  child: Image.asset(
                    ('assets/images/avatar.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16, bottom: 4),
                child: Text(
                  "${loggedInUser.name}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                "${loggedInUser.kategori}",
                style: TextStyle(color: darkColor),
              ),
            ],
          ),
          // section 2 - menu
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 42),
            child: Column(
              children: [
                MenuTile(
                  title: 'Update Profile',
                  icon: Icon(Icons.person),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
                    );
                  },
                ),
                SizedBox(),
                MenuTile(
                  title: 'Pengaturan Akun',
                  icon: Icon(Icons.settings),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountSettingScreen()),
                    );
                  },
                ),
                MenuTile(
                  isDanger: true,
                  title: 'Keluar',
                  icon: Icon(Icons.logout),
                  onTap: () {
                    logout(context);
                  }
                ),
                Container(
                  height: 1,
                  color: primaryExtraSoft,
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}

class MenuTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final void Function() onTap;
  final bool isDanger;
  MenuTile({
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: greyColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              margin: EdgeInsets.only(right: 24),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryExtraSoft,
                borderRadius: BorderRadius.circular(100),
              ),
              child: icon,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: (isDanger == false) ? secondary : error,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24),
              child: Icon(
                Icons.arrow_right)
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => LoginScreen()));
}