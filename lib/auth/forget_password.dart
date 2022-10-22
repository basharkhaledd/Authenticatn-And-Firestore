import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController controllerEmail = TextEditingController();

  Future? sendPasswordReset() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: controllerEmail.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            child: TextFormField(
                controller: controllerEmail,
                minLines: 1,
                maxLines: 3,
                maxLength: 200,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Enter your email",
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                sendPasswordReset();
              },
              child: Text("RESET"),
            ),
          )
        ],
      ),
    );
  }
}
