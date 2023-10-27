// @dart=2.9

import 'package:absensi/common/common.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDatePicker extends StatelessWidget {
  final String labelText;
  var controller = new TextEditingController();
  final String hintText;
  final String errorValidation;
  final Color hintColor;
  final Color iconColor;
  final VoidCallback onTap;

  CustomDatePicker({this.labelText, this.controller, this.hintText, this.errorValidation, this.hintColor, this.iconColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelText,
              style: TextStyle(fontSize: 16),
            ),
            if (errorValidation != null) Text(
              errorValidation,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Material(
          borderRadius: BorderRadius.circular(8),
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black)
            ),
            child: InkWell(
              onTap: onTap,
              child: Container(
                width: defaultWidth(context),
                padding: EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12.5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hintText,
                      style: semiBlackFont.copyWith(
                        fontSize: 15,
                        color: hintColor,
                      ),
                    ),
                    FaIcon(
                      FontAwesomeIcons.solidCalendar,
                      color: iconColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}