import 'package:absensi/Controller/detail_presence_controller.dart';
import 'package:absensi/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailPresenceScreen extends GetView<DetailPresenceController> {
  final Map<String, dynamic> presenceData = Get.arguments;
  static String routeName = "/detail_presence_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Absensi',
          style: TextStyle(
            color: secondary,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: secondaryExtraSoft,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        children: [
          // check in ============================================
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: secondaryExtraSoft, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'absen masuk',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 4),
                        Text(
                          (presenceData["masuk"] == null) ? "-" : "${DateFormat.jm().format(DateTime.parse(presenceData["masuk"]["date"]))}",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    //presence date
                    Text(
                      "${DateFormat.yMMMMEEEEd("id").format(DateTime.parse(presenceData["date"]))}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 14),
                Text(
                  'nama',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  (presenceData["masuk"] == null) ? "-" : "${(presenceData["masuk"]["name"])}",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 14),
                Text(
                  'status',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  (presenceData["masuk"]["in_area"] == true) ? "Absensi didalam area kantor" : "Absensi diluar area kantor",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 14),
                Text(
                  'alamat',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  (presenceData["masuk"] == null) ? "-" : "${presenceData["masuk"]["address"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 150 / 100,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          // check out ===========================================
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: secondaryExtraSoft, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'absen pulang',
                          style: TextStyle(color: secondary),
                        ),
                        SizedBox(height: 4),
                        Text(
                          (presenceData["keluar"] == null) ? "-" : "${DateFormat.jm().format(DateTime.parse(presenceData["keluar"]["date"]))}",
                          style: TextStyle(color: secondary, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    //presence date
                    Text(
                      "${DateFormat.yMMMMEEEEd("id").format(DateTime.parse(presenceData["date"]))}",
                      style: TextStyle(color: secondary),
                    ),
                  ],
                ),
                SizedBox(height: 14),
                Text(
                  'nama',
                  style: TextStyle(color: secondary),
                ),
                SizedBox(height: 4),
                 Text(
                  (presenceData["keluar"] == null) ? "-" : "${(presenceData["keluar"]["name"])}",
                  style: TextStyle(color: secondary, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 14),
                Text(
                  'status',
                  style: TextStyle(color: secondary),
                ),
                Text(
                  (presenceData["keluar"] == null) ? "-" : "Absensi didalam area kantor",
                  style: TextStyle(color: secondary, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 14),
                Text(
                  'alamat',
                  style: TextStyle(color: secondary),
                ),
                SizedBox(height: 4),
                Text(
                  (presenceData["keluar"] == null) ? "-" : "${presenceData["keluar"]["address"]}",
                  style: TextStyle(
                    color: secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 150 / 100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
