import 'package:flutter/material.dart';
import 'package:postool_9/service_locator.dart';
import 'package:postool_9/ui/views/login/login_page.dart';
import 'package:postool_9/utils/db_helper.dart';

void main() {
  setupLocator();
  runApp(MyApp());
  DBHelper.init();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '牛頭新pos',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LoginPage(),
    );
  }
}
