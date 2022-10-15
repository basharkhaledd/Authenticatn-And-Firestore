import 'package:boom_boom/auth/signup.dart';
import 'package:boom_boom/component/alert.dart';
import 'package:boom_boom/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
              margin: EdgeInsets.only(top: 50),
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
                  controller: controllerEmail,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Email",
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 2))),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: controllerPassword,
                  obscureText: false,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "password",
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 2))),
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text("if you havan't accout "),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return SignUp();
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

                          if (controllerEmail.text.isNotEmpty &&
                              controllerPassword.text.isNotEmpty) {
                            showLoading(context);
                          }

                          UserCredential myUser = await objectFromFirebaseAuth
                              .signInWithEmailAndPassword(
                                  email: controllerEmail.text,
                                  password: controllerPassword.text);

                          setState(() {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Home();
                            }));
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("chek your password or email")));
                        }
                      },
                      child: Text(
                        "Login",
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
