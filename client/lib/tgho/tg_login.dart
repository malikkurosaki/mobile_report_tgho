import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobile_report/tgho/tg_conn.dart';
import 'package:mobile_report/tgho/tg_router.dart';
import 'package:mobile_report/tgho/tg_util_pref.dart';

class TgLogin extends StatelessWidget {
  TgLogin({Key? key}) : super(key: key);
  final body = {
    "name": "",
    "password": ""
  };

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
            child: Column(
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.account_circle,
                          size: 100,
                          color: Colors.blueGrey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Tg Login",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      // description info
                      Center(
                        child: Text("lengkapi data dibawa ini untuk melanjutkan", 
                          style: TextStyle(
                            color: Colors.blueGrey
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      // input form username
                      ListTile(
                        title: TextField(
                          onChanged: (value) => body['name']  = value,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_box_rounded),
                            labelText: "Username",
                            fillColor: Colors.blueGrey[50],
                            filled: true,
                            border: InputBorder.none
                          ),
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: Colors.blueGrey,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Center(
                        child: Text("Login",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    onPressed: ()async {
                      final login = await TgConn().login(body);

                      if(login.body['success'].toString() == "true"){
                        TgUtilPref.user(value: login.body['data']);
                        TgRouter.root().goOffAll();
                        return;
                      }

                      EasyLoading.showToast("user or password failed");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
