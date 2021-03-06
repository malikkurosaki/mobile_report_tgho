import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect.dart';
import 'package:mobile_report/tgho/tg_config.dart';
import 'package:mobile_report/tgho/tg_conn.dart';
import 'package:mobile_report/tgho/tg_router.dart';
import 'package:mobile_report/tgho/tg_util_load.dart';
import 'package:mobile_report/tgho/tg_util_pref.dart';

class TgLogin extends StatelessWidget {
  TgLogin({Key? key}) : super(key: key);
  final body = {"name": "", "password": ""};

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueGrey[800],
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            child: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  TgUtilLoad().ping(),
                  Image.asset("assets/images/bg_login.png"),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Icon(
                  //     Icons.account_circle,
                  //     size: 100,
                  //     color: Colors.blueGrey,
                  //   ),
                  // ),
                  // description info
                  Center(
                    child: Text(
                      "lengkapi data dibawa ini untuk melanjutkan",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // input form username
                  ListTile(
                    title: TextField(
                      onChanged: (value) => body['name'] = value,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_box_rounded),
                          labelText: "Username",
                          fillColor: Colors.blueGrey[50],
                          filled: true,
                          border: InputBorder.none),
                    ),
                  ),
                  // input form password
                  ListTile(
                    title: TextField(
                      onChanged: (value) => body['password'] = value,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: "password",
                          fillColor: Colors.blueGrey[50],
                          filled: true,
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ListTile(
                    title: MaterialButton(
                      color: Colors.blue,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          final login = await TgConn().login(body);
                          print(TgConfig.baseUrl);

                          if (login.body['success'].toString() == "true") {
                            TgUtilPref.user(value: login.body['data']);
                            TgRouter.root().goOffAll();
                            return;
                          }

                          EasyLoading.showToast("user or password failed");
                        } catch (e) {
                          print(e.toString());
                          EasyLoading.showToast(e.toString());
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
}
