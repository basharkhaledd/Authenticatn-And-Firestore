import 'package:boom_boom/crud/additems.dart';
import 'package:boom_boom/crud/editeaitems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../component/drawer.dart';

class HomeAdmain extends StatefulWidget {
  @override
  _HomeAdmainState createState() => _HomeAdmainState();
}

class _HomeAdmainState extends State<HomeAdmain> {
  // getData() async {

  //   DocumentReference doc = FirebaseFirestore.instance.collection("items").doc("Bnj1hXOa8FYiz9OweP0s");
  //   await doc.get().then((value) => print(value.exists));

  // }

  Stream<QuerySnapshot> items =
      FirebaseFirestore.instance.collection("items").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 61, 105, 147),
        title: Text('HomeAdmain'),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 61, 105, 147),
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Additems();
            }));
          }),
      body: StreamBuilder(
          stream: items,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List itemList = snapshot.data!.docs;
              return ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      "${itemList[index]["cars-name"]}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    subtitle: Text(
                      "${itemList[index]["cars-number"]}",
                      style:
                          TextStyle(color: Colors.green.shade900, fontSize: 15),
                    ),
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(
                          "https://cdn.iconscout.com/icon/premium/png-256-thumb/jeep-549-531521.png"),
                      radius: 30,
                    ),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return EditItems();
                                }));
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () async {
                                final item = FirebaseFirestore.instance
                                    .collection("items")
                                    .doc("$index");
                                item.delete();
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: Text(""),
            );
          }),
    );
  }
}
