import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobile_report/v2_util.dart';

class V2Register extends StatelessWidget {
  V2Register({Key? key}) : super(key: key);
  final conUserName = TextEditingController();
  final conEmail = TextEditingController();
  final conPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(),
            Flexible(
              child: ListView(
                children: [
                  Text(
                    "Register",
                    style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  formInput(hint: "User Name", con: conUserName),
                  formInput(hint: "Email", con: conEmail),
                  formInput(hint: "Password", con: conPassword)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                padding: EdgeInsets.all(12),
                child: Container(
                    width: double.infinity,
                    child: Center(child: Text("REGISTER"))),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  final body = {
                    "name": conUserName.text,
                    "password": conPassword.text,
                    "email": conEmail.text
                  };

                  if (body.values.contains("")) {
                    EasyLoading.showError("No Empty Allowed");
                    return;
                  }

                  V2Util().toRegister(body);

                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget formInput(
          {required String hint, required TextEditingController con}) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: con,
          decoration: InputDecoration(
              hintText: hint, border: OutlineInputBorder(), isDense: true),
        ),
      );
}
