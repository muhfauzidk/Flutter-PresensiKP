

import 'package:absensi/common/common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PresenceCard extends StatelessWidget {
  final Map<String, dynamic> userData;
  final Map<String, dynamic>? todayPresenceData;
  PresenceCard({required this.userData, required this.todayPresenceData});

  // String kategori;
  // String mulaiMagang;
  // String akhirMagang;
  // String asalInstansi;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 24, top: 24, right: 24, bottom: 16),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // job
          Text(
            userData["kategori"] + ' dari ' + userData["asalInstansi"],
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          // //  Waktu magang
          // Container(
          //   margin: EdgeInsets.only(top: 4, bottom: 12),
          //   child: Row(
          //     children: [
          //       //  check in
          //       Expanded(
          //         child: Column(
          //           children: [
          //             Text(
          //               mulaiMagang,
          //               style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w700,
          //                 color: Colors.white,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         width: 10,
          //         height: 2,
          //         color: Colors.white,
          //       ),
          //       // check out
          //       Expanded(
          //         child: Column(
          //           children: [
          //             Text(
          //               akhirMagang,
          //               style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w700,
          //                 color: Colors.white,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // check in - check out box
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              color: darkColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                //  check in
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 6),
                        child: Text(
                          "Absen Masuk",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        (todayPresenceData?["masuk"] == null) ? "-" : "${DateFormat.jms().format(DateTime.parse(todayPresenceData!["masuk"]["date"]))}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1.5,
                  height: 24,
                  color: Colors.white,
                ),
                // check out
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 6),
                        child: Text(
                          "Absen Pulang",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        (todayPresenceData?["keluar"] == null) ? "-" : "${DateFormat.jms().format(DateTime.parse(todayPresenceData!["keluar"]["date"]))}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
