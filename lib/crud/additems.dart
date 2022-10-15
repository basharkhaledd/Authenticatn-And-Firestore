import 'package:boom_boom/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Additems extends StatefulWidget {
  const Additems({super.key});

  @override
  State<Additems> createState() => _AdditemsState();
}

class _AdditemsState extends State<Additems> {
  TextEditingController controllerCarsName = TextEditingController();
  TextEditingController controllerCarsNumber = TextEditingController();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add car'),
      ),
      body: Container(
          child: ListView(
        children: [
          Form(
              key: formstate,
              child: Column(children: [
                TextFormField(
                  controller: controllerCarsName,
                  maxLength: 30,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "car's Nmae",
                      prefixIcon: Icon(Icons.car_crash)),
                ),
                TextFormField(
                  controller: controllerCarsNumber,
                  minLines: 1,
                  maxLines: 3,
                  maxLength: 200,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "car's Number",
                      prefixIcon: Icon(Icons.car_crash)),
                ),
                ElevatedButton(
                  onPressed: () {
                    final items = Items(
                        carsname: controllerCarsName.text,
                        carsnumber: controllerCarsNumber.text);

                    createitem(items: items);
                    Navigator.of(context)
                        .pop(MaterialPageRoute(builder: (context) {
                      return Home();
                    }));
                  },
                  //
                  child: Text(
                    "Add car",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              ]))
        ],
      )),
    );
  }

  Future createitem({required Items items}) async {
    final item = FirebaseFirestore.instance.collection("items").doc();

    final json = items.toJson();
    await item.set(json);
  }
}

class Items {
  final String carsname;
  final String carsnumber;
  Items({required this.carsname, required this.carsnumber});
  Map<String, dynamic> toJson() =>
      {'cars-name': carsname, 'cars-number': carsnumber};
}
