import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mobile_report/tgho/tg_util_pref.dart';
import 'package:mobile_report/tgho/tg_router.dart';
import 'package:get/get.dart';

class TgSidebar extends StatelessWidget {
  const TgSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            height: 100,
            color: Colors.white,
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Icon(Icons.account_circle, size: 50, color: Colors.blueGrey[400]),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&w=1000&q=80"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      (TgUtilPref.user().get()['name'] ?? "loading ...").toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            onTap: () {},
            title: Text("Home"),
          ),
          ListTile(
            leading: Icon(Icons.stairs_outlined),
            onTap: () {},
            title: Text("Product"),
          ),
          // performance report
          ListTile(
            leading: Icon(Icons.settings_input_antenna),
            onTap: () {},
            title: Text("Performance"),
          ),
          // dept report
          ListTile(
            leading: Icon(Icons.account_tree_sharp),
            onTap: () {},
            title: Text("Dept Report"),
          ),
          ListTile(
            leading: Icon(Icons.new_releases_sharp),
            onTap: () {},
            title: Text("News"),
          ),
          ListTile(
            leading: Icon(Icons.settings_system_daydream),
            onTap: () {},
            title: Text("Products"),
          ),
          ListTile(
            leading: Icon(Icons.bug_report_outlined),
            onTap: () => TgRouter.developer().go(),
            title: Text("Developers"),
          ),
          // logout
          ListTile(
            leading: Icon(Icons.exit_to_app),
            onTap: () {
             Get.dialog(
                AlertDialog(
                  title: Text("Logout"),
                  content: Text("Are you sure?"),
                  actions: [
                    MaterialButton(
                      child: Text("Yes"),
                      onPressed: () {
                        TgUtilPref.user(value: {});
                        TgRouter.root().goOff();
                      },
                    ),
                    MaterialButton(
                      child: Text("No"),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              );
            },
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
