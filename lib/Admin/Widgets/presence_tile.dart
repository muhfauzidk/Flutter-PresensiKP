import 'package:absensi/Screens/detail_presence_screen.dart';
import 'package:absensi/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PresenceTile extends StatelessWidget {
  final Map<String, dynamic> presenceData;
  PresenceTile({required this.presenceData});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Get.toNamed(DetailPresenceScreen.routeName, arguments: presenceData),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: primaryExtraSoft,
          ),
        ),
        padding: EdgeInsets.only(left: 24, top: 20, right: 29, bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Text(
                      (presenceData["masuk"] == null)
                          ? "-"
                          : "${(presenceData["masuk"]["name"])}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 24),
              ],
            ),
            Text(
              "${DateFormat.yMMMMEEEEd("id").format(DateTime.parse(presenceData["date"]))}",
              style: TextStyle(
                fontSize: 10,
                color: secondarySoft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
