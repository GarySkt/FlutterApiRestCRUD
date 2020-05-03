import 'package:flutter/material.dart';
import 'package:todo/pages/settings.dart';
import 'package:todo/pages/todo.dart';
import 'package:todo/pages/todoArchive.dart';

class MainTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: new Scaffold(
          body: TabBarView(
            children: <Widget>[
              TodoPage(),              
              Archive(),
              Settings()
            ],),
            bottomNavigationBar: PreferredSize(
              preferredSize: Size(60.0, 60.0),
              child: Container(
                height: 60.0,
                child: TabBar(
                  labelColor: Theme.of(context).primaryColor,
                  labelStyle: TextStyle(fontSize: 10.0),
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.list),
                      text: 'Todo',
                    ),
                    Tab(
                      icon: Icon(Icons.history),
                      text: 'Archive',
                    ),
                    Tab(
                      icon: Icon(Icons.settings),
                      text: 'Settings',
                    ),
                  ],
                ),
              ),),
        ),
        ),
    );
  }
}