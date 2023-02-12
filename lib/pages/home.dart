// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_appli1/auth.dart';
import 'package:flutter/material.dart';
import './connexion_page.dart';
import 'add_event.dart';
import "../dbhelper.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = "il n'y a rien";
  final User? user = Auth().currentUser;
  final dbHelper = DatabaseHelper.instance;
  Future<void> signOut() async {
    await Auth().signOut();
  }

  String _userUid() {
    return user?.email ?? 'User email';
  }

  Widget buttonConnexion() {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        child: const Text('Connexion'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ConnexionPage(),
            ),
          );
        },
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Container()),
        );
        break;
      case 1:

      case 2:
        signOut();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ConnexionPage()),
          (route) => false,
        );
    }
  }

  Widget menuButton() {
    return PopupMenuButton<int>(
      color: Colors.indigo,
      onSelected: (item) => onSelected(context, item),
      itemBuilder: (context) => [
        const PopupMenuItem<int>(
          value: 0,
          child: Text('Settings'),
        ),
        // const PopupMenuItem<int>(
        //   value: 1,
        //   child: Text('Add a new event'),
        // ),
        const PopupMenuDivider(),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: const [
              Icon(Icons.logout),
              SizedBox(width: 8),
              Text('Sign Out'),
            ],
          ),
        ),
      ],
    );
  }

  void navAddEvent() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddEvent(),
      ),
    );
  }

  List<Map<String, dynamic>> allRows = [];

  void _queryAll() async {
    allRows = await dbHelper.queryAllRows();
    // cars.clear();
    // allRows.forEach((row) => cars.add(Car.fromMap(row)));
    // _showMessageInScaffold('Query done.');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Hi ${_userUid()}"),
        ),
        actions: <Widget>[
          buttonConnexion(),
          menuButton(),
        ],
      ),
      body: Center(
        child: Container(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: allRows.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == allRows.length) {
                return ElevatedButton(
                  child: const Text('Refresh'),
                  onPressed: () {
                    setState(() {
                      _queryAll();
                    });
                  },
                );
              }
              return Container(
                height: 40,
                child: Center(
                  child: Text(
                    '[${allRows[index]["id"]}] ${allRows[index]["name"]} - ${allRows[index]["date"].substring(0, 10)} - ${allRows[index]["description"]}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {navAddEvent()},
        tooltip: 'Increment',
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
