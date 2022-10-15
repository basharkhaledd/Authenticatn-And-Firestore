import 'package:boom_boom/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditItems extends StatefulWidget {
  const EditItems({super.key});

  @override
  State<EditItems> createState() => _EditItemsState();
}

class _EditItemsState extends State<EditItems> {
  var carsName, carsNumber;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 61, 105, 147),
        title: Text('Edit car'),
      ),
      body: Container(
          child: Column(
        children: [
          Form(
              key: formstate,
              child: Column(children: [
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  onSaved: (val) {
                    carsName = val;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "car's name",
                      prefixIcon: Icon(Icons.car_crash)),
                ),
                TextFormField(
                  onSaved: (val) {
                    carsNumber = val;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "car's number",
                      prefixIcon: Icon(Icons.car_crash)),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 61, 105, 147),
                  )),
                  onPressed: () async {
                    final item =
                        FirebaseFirestore.instance.collection("items").doc();
                    item.update(
                        {'cars-name': carsName, 'cars-number': carsNumber});
                    Navigator.of(context)
                        .pop(MaterialPageRoute(builder: (context) {
                      return Home();
                    }));
                  },
                  child: Text(
                    "Edit cars",
                  ),
                )
              ]))
        ],
      )),
    );
  }
}
