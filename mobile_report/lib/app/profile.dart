import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/instance_manager.dart';
import 'package:mobile_report/pref.dart';
import 'package:get/get.dart';
import 'package:mobile_report/splash.dart';
import 'package:mobile_report/v2_pref.dart';
import 'package:mobile_report/v2_splash.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[200],
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey[800],
                height: 200,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(
                      color: Colors.white,
                    ),
                    Row(
                      children: [
                        Hero(
                          tag: "profile",
                          child: Icon(
                            Icons.account_circle,
                            size: 54,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Account Name",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SettingOrderBytime(),
              ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.logout),
                onTap: () {
                  EasyLoading.showError("kerjakan disini");
                  // V2Pref.user().del();
                  // Get.offAll(V2Splash());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingOrderBytime extends StatelessWidget {
  const SettingOrderBytime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Ajust Time Report",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                ),
                itemSettingTime("Breakfast"),
                itemSettingTime("Lanch"),
                itemSettingTime("Coffee Break"),
                itemSettingTime("Dinner")
              ],
            ),
          )
        ],
      ),
    );
  }

  itemSettingTime(String title) => ListTile(
        isThreeLine: true,
        title: Text(
          title,
          style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        subtitle: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "05:20",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                ),
                Text(
                  "09:30",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Start"), Text("End")],
            )
          ],
        ),
        leading: Icon(
          Icons.timer_rounded,
          size: 40,
        ),
        // trailing: Container(
        //   height: double.infinity,
        //   child: Icon(Icons.arrow_drop_down, size: 40,)
        // ),
      );
}
