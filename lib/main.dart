import 'package:aadj/auth/auth_page.dart';
import 'package:aadj/core/globals.dart';
import 'package:aadj/core/myapp.dart';
import 'package:aadj/widgets/account_view.dart';
import 'package:aadj/widgets/post_view.dart';
import 'package:flutter/material.dart';

import 'widgets/bottom_navigation_bar.dart';

// //todo ASK ABOUT NOTIFICATIONS PROBLEM

void main() {
  runApp(const MaterialApp(
      home: StatusWidget(
    statusId: '112497942836430426',
  ))); //AuthPage AppBottomBar MyApp AccountPropertiesWidget(accountId: myAccount)
}
