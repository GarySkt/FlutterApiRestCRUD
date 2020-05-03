import 'package:flutter/material.dart';

class HiddenScrollBehavior extends ScrollBehavior{
  
  Widget buildViewPortChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection){
      return child;
    }      
  
}