import 'package:boom_boom/home/home_admain.dart';
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
        backgroundColor: Color.fromARGB(255, 61, 105, 147),
        title: Text('Add car'),
      ),
      body: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                          prefixIcon: Icon(Icons.car_crash_outlined,
                              color: Colors.red.shade900)),
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
                          prefixIcon: Icon(
                            Icons.car_crash_outlined,
                            color: Colors.red.shade900,
                          )),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 61, 105, 147),
                      )),
                      onPressed: () {
                        final items = Items(
                            carsname: controllerCarsName.text,
                            carsnumber: controllerCarsNumber.text);

                        createitem(items: items);
                        Navigator.of(context)
                            .pop(MaterialPageRoute(builder: (context) {
                          return HomeAdmain();
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
