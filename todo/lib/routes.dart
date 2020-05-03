import 'package:flutter/material.dart';
import 'package:todo/pages/forgotpwd.dart';
import 'package:todo/pages/login.dart';
import 'package:todo/pages/maintabs.dart';
import 'package:todo/pages/register.dart';

Map<String, WidgetBuilder> buildAppRoutes(){
  return{
    '/login': (BuildContext context) => LoginPage(),
    '/register' : (BuildContext context) => RegisterPage(),
    '/forgot' : (BuildContext context) => ForgotPWD(),
    '/maintabs': (BuildContext context)=> MainTabs(),
  };
}