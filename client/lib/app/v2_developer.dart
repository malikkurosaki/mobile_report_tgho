import 'package:flutter/material.dart';
import 'package:mobile_report/app/v2_register.dart';
import 'package:mobile_report/v2_util.dart';
import 'package:mobile_report/v2_val.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class V2Developer extends StatelessWidget {
  const V2Developer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Developer ",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
            ),
            Flexible(
              child: ListView(
                children: [
                  ExpansionTile(
                    leading: Icon(Icons.account_circle),
                    expandedAlignment: Alignment.topLeft,
                    title: Text("List User"),
                    children: [
                      for (final lu in V2Val.listUser)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(lu.email.toString()),
                            ),
                            Divider()
                          ],
                        )
                    ],
                    onExpansionChanged: (value) {
                      V2Util().getListUser();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.add_reaction_rounded),
                    title: Text("Register"),
                    onTap: () => Get.to(V2Register()),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  CheckboxListTile(
                    tristate: true,
                    title: Text("Is DEbug"),
                    value: V2Val.config.value.isDebug,
                    onChanged: (value) {
                      V2Val.config.value.isDebug = !V2Val.config.value.isDebug!;
                      V2Val.config.refresh();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
