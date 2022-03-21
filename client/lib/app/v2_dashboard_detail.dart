import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:mobile_report/v2_models.dart';
import 'package:mobile_report/v2_util.dart';
import 'package:mobile_report/v2_val.dart';

class V2DashboardDetail extends StatefulWidget {
  const V2DashboardDetail(
      {Key? key,
      required this.heroTag1,
      required this.icon1,
      required this.title, required this.modelData, required this.lsTop10})
      : super(key: key);
  final String heroTag1;
  final IconData icon1;
  final String title;
  final V2ModelFood modelData;
  final RxList<V2ModelTop10> lsTop10;

  @override
  _V2DashboardDetailState createState() => _V2DashboardDetailState();
}

class _V2DashboardDetailState extends State<V2DashboardDetail> {
  @override
  void initState() {
    EasyLoading.showInfo("load ...");
    V2Util().loadTop10Food();
    V2Util().loadTop10Beverage();
    V2Util().loadTop10Other();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              Card(
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: widget.heroTag1,
                        child: Row(
                          children: [
                            CircleAvatar(child: Icon(widget.icon1)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 36),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              lsItem("Gross", widget.modelData.gtotal.toString()),
              Divider(),
              lsItem("Total", widget.modelData.total.toString()),
              Divider(),
              lsItem("Net", widget.modelData.net.toString()),
              Divider(),
              lsItem("Bill", widget.modelData.bill.toString()),
              Divider(),
              lsItem("Compliment", widget.modelData.compliTotal.toString()),
              Divider(),
              Card(
                color: Colors.cyan[100],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Top 10 ${widget.title}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan[800]
                          ),
                        ),
                        for(final nn in widget.lsTop10)
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(nn.id.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.cyan
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(nn.qty.toString(),
                                      style: TextStyle(
                                        color: Colors.cyan[800],
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Divider(color: Colors.white,)
                          ],
                        )
                      ],
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget lsItem(String title, String value) =>
  Row(
    children: [
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey
            ),
          ),
        )
      ),
      Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87
            ),
          ),
        )
      )
    ],
  );
}
