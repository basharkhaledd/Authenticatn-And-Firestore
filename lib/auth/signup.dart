import 'package:boom_boom/auth/login.dart';
import 'package:boom_boom/component/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 20),
          Container(
              height: 200,
              child: Image.network(
                "https://t4.ftcdn.net/jpg/03/22/95/97/360_F_322959737_sZAfSCd1ufWwPhlrwSyFwCz1vhoobR6K.jpg",
                fit: BoxFit.fill,
              )),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "username",
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1))),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "email",
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1))),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: password,
                  obscureText: false,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "password",
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1))),
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text("if you have Account "),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Login();
                            }));
                          },
                          child: Text(
                            "Click Here",
                            style: TextStyle(color: Colors.blue.shade900),
                          ),
                        )
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: 30),
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        Colors.black45,
                      )),
                      onPressed: () async {
                        try {
                          var objectFromFirebaseAuth = FirebaseAuth.instance;

                          UserCredential myUser = await objectFromFirebaseAuth
                              .createUserWithEmailAndPassword(
                                  email: email.text, password: password.text);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("saved")));
                        } catch (e) {
                          if (email.text.isEmpty || password.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Missing Value")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("the email already founded")));
                          }
                          // showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return AlertDialog(
                          //         content: Text("the email already founded"),
                          //       );
                          //     });
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ))
              ],
            )),
          )
        ],
      ),
    );
  }
}
