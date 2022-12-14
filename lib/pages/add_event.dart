// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import "package:flutter/cupertino.dart";

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEvent();
}

class _AddEvent extends State<AddEvent> {
  final database = FirebaseDatabase.instance;

  DateTime dateTime = DateTime(2022, 12, 1, 10, 20);
  final TextEditingController description = TextEditingController();
  String? errorMessage = '';
  final TextEditingController name = TextEditingController();
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () => {
        ref
            .child(("NameEvent"))
            .push()
            .child("nameEvent")
            .set(name.text)
            .asStream(),
        name.clear(),
      },
      child: const Text("créer un évènement"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ref = database.ref();
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
