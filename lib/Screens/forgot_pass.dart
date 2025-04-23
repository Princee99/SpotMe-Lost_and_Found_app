import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController emailcontroller = TextEditingController();
  Future<void> reset() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailcontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Center(
              child: Text(
            "Forgot Password",
            style: TextStyle(fontSize: 20),
          )),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: emailcontroller,
            decoration: InputDecoration(hintText: "Email"),
          ),
          ElevatedButton(
              onPressed: () {
                reset();
              },
              child: Text("Reset Password"))
        ],
      ),
    ));
  }
}
