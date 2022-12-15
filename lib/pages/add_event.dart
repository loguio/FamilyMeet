import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import "package:flutter/cupertino.dart";
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import "../dbhelper.dart";

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEvent();
}

class _AddEvent extends State<AddEvent> {
  // final database = FirebaseDatabase.instance;
  final dbHelper = DatabaseHelper.instance;

  DateTime dateTime = DateTime(2022, 12, 1, 10, 20);
  final TextEditingController description = TextEditingController();
  String? errorMessage = '';
  final TextEditingController name = TextEditingController();
  // DatabaseReference ref = FirebaseDatabase.instance.ref();
  Future<void> connectDB() async {
    await dbHelper.insert();
    final allRows = await dbHelper.queryAllRows();
    // print(allRows);
    // print(join(await getDatabasesPath(), "cardb.db"));
  }

  // Future<void> insertDog(Dog dog, database) async {
  //   // Get a reference to the database.
  //   final db = await database;

  //   // Insert the Dog into the correct table. You might also specify the
  //   // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //   //
  //   // In this case, replace any previous data.
  //   await db.insert(
  //     'dogs',
  //     dog.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () => {connectDB()},
      child: const Text("créer un évènement"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white.withOpacity(0),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Color.fromARGB(255, 29, 8, 8),
                  size: 30,
                ))),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
                child: const FlutterLogo(
                  size: 40,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Name',
                  ),
                  controller: name,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Description',
                  ),
                  controller: description,
                ),
              ),
              CupertinoButton(
                  child: Text(
                    DateFormat("dd-MM-yyyy").format(dateTime),
                    style: const TextStyle(fontSize: 24),
                  ),
                  onPressed: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext) => SizedBox(
                              height: 250,
                              child: CupertinoDatePicker(
                                backgroundColor: Colors.white,
                                initialDateTime: dateTime,
                                onDateTimeChanged: (DateTime newTime) {
                                  setState(() => dateTime = newTime);
                                },
                                use24hFormat: true,
                                mode: CupertinoDatePickerMode.date,
                              ),
                            ));
                  }),
              _submitButton()
            ],
          ),
        ));
  }
}

class Dog {
  final int id;
  final String name;
  final int age;

  const Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
