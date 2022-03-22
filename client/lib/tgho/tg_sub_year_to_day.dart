import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'tg_util_pref.dart';

class TgSubYearToDay extends StatelessWidget {
  const TgSubYearToDay({ Key? key, required this.sizingInformation }) : super(key: key);
  final SizingInformation sizingInformation;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
      Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 24),
              color: Colors.blueGrey[230],
              child: Wrap(
                children: [
                  for (final r in TgUtilPref.reportByTotalX.keys)
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: sizingInformation.isMobile ? 500 : Get.width / 4,
                        height: 230,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Image.network(
                                "https://i.postimg.cc/bY5Ppn8Z/image.png",
                                fit: BoxFit.cover,
                                width: double.infinity,
                                cacheHeight: 230,
                                cacheWidth: 230,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.9)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "This " + r.toString(),
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyan),
                                ),
                                Text(
                                  DateFormat("dd MMMM yyyy")
                                      .format(DateTime.parse(TgUtilPref.reportX['date'].toString())),
                                  style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey),
                                ),
                                Divider(),
                                // gross
                                Text("GROSS"),
                                Text(
                                  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(
                                    int.tryParse(
                                      (TgUtilPref.reportByTotalX[r]['_sum']['total'] ?? 0).toString(),
                                    ),
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey[200],
                                  ),
                                ),
                                // net
                                Text("NET"),
                                Text(
                                  NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(
                                    int.tryParse(
                                      (TgUtilPref.reportByTotalX[r]['_sum']['net'] ?? 0).toString(),
                                    ),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                // pax
                                Text("PAX"),
                                Text(
                                  (TgUtilPref.reportByTotalX[r]['_sum']['pax'] ?? 0).toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            )
          ],
        )
    )
    ;
  }
}