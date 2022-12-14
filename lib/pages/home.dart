import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_appli1/auth.dart';
import 'package:flutter/material.dart';
import './connexion_page.dart';
import 'add_event.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = "il n'y a rien";
  final User? user = Auth().currentUser;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[],
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
