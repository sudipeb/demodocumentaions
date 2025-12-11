import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Sign In")),
      body: SizedBox(
        child: Column(children: [Text("Verification of Sign In")]),
      ),
    );
  }
}
