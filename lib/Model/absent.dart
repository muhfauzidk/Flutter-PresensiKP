// @dart=2.9

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Absent extends Equatable {
  final String userID;
  final String userName;
  final String userPhoto;
  final DateTime absentTime;
  final String absentType;

  Absent({
    @required this.userID,
    @required this.userName,
    @required this.userPhoto,
    @required this.absentTime,
    @required this.absentType,
  });

  @override
  List<Object> get props => [userID, userName, userPhoto, absentTime, absentType];
}
