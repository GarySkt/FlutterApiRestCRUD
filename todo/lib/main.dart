import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/maintabs.dart';
import 'package:todo/pages/register.dart';
import 'package:todo/routes.dart';
import 'package:todo/theme.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {

  Widget rootPage = RegisterPage();

  Future<Widget> getRootPage() async =>
  await FirebaseAuth.instance.currentUser() == null
  ? RegisterPage()
  : MainTabs();
  
  //cuando la vista es creada
  @override
  initState() {    
    super.initState();
    getRootPage().then((Widget page){
      setState((){
        rootPage = page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: rootPage,
      routes: buildAppRoutes(),
      theme: buildAppTheme(),
    );
  }
}