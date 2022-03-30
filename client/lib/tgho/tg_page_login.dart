import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/utils.dart';
import 'package:mobile_report/tgho/tg_config.dart';
import 'package:mobile_report/tgho/tg_conn.dart';
import 'package:mobile_report/tgho/tg_util_load.dart';
import 'package:mobile_report/tgho/tg_util_pref.dart';
import 'package:mobile_report/tgho/tg_util_router.dart';

class TgPageLogin extends StatelessWidget {
  TgPageLogin({Key? key}) : super(key: key);
  final body = {"name": "", "password": ""};

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueGrey[50],
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
                  // Text(GetPlatform.isAndroid.toString()),
                  TgUtilLoad().ping(),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 200,
                      child: Image.network(
                        "https://i.postimg.cc/XJYdfcjT/image.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Icon(
                  //     Icons.account_circle,
                  //     size: 100,
                  //     color: Colors.blueGrey,
                  //   ),
                  // ),
                  // description info
                  ListTile(
                    title: Text(
                      "lengkapi data dibawa ini untuk melanjutkan",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
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
                        padding: EdgeInsets.all(12),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        EasyLoading.showInfo("login ...", dismissOnTap: true);
                        try {
                          final login = await TgConn().login(body);
                          print(TgConfig.baseUrl);

                          if (login.body['success'].toString() == "true") {
                            TgUtilPref.user(value: login.body['data']);
                            TgUtilRouter.root().goOffAll();
                            return;
                          }

                          EasyLoading.showToast("user or password failed");
                        } catch (e) {
                          print(e.toString());
                          EasyLoading.showToast(e.toString());
                        }

                        EasyLoading.dismiss();
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
