// @dart=2.9

import 'package:flutter/material.dart';

void showAlert(BuildContext context, {Widget alert}) {
  showDialog(
    context: context,
    builder: (context) => alert,
  );
}