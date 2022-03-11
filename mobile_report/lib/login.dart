import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_builder/responsive_builder.dart';
import 'package:mobile_report/v2_error_log.dart';
import 'package:mobile_report/v2_util.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final conEmail = TextEditingController();
  final conPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    onLoad();
    return ResponsiveBuilder(
      builder: (a, b) => Material(
        color: Colors.blueGrey[200],
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Login Mobile Report",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Text(
                              "Enter the email and password that you have previously, to proceed to the next process",
                              style: TextStyle(color: Colors.grey[700]),
                            )),
                        Container(
                          padding: EdgeInsets.only(bottom: 16),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: conEmail,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                                labelText: "Email",
                                border: OutlineInputBorder(),
                                isDense: true,
                                hintText: "email"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 16),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: conPassword,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                                labelText: "Password",
                                border: OutlineInputBorder(),
                                isDense: true,
                                hintText: "password"),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: MaterialButton(
                      padding: EdgeInsets.all(16),
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Center(
                        child: Text("LOGIN"),
                      ),
                      onPressed: () async {
                        try {
                          final body = {
                            "email": conEmail.text,
                            "password": conPassword.text
                          };

                          final cek = body.values;
                          if (cek.contains("")) {
                            EasyLoading.showError(
                                "please not empty event of one filed");
                            return;
                          }

                          await V2Util().login(body);

                          // final lgn = await V2Conn().login(body);

                        } catch (e) {
                          ErrorLog().create("login:onlogin", e.toString());
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onLoad() async {}
}
