import 'package:flutter/material.dart';
import 'package:mobile_report/tgho/tg_util_router.dart';
import 'package:mobile_report/tgho/tg_util_pref.dart';

final wellcomes = [
  {
    "title": "Gross Sales",
    "subtitle":
        "The overall revenue from sales transactions at outlets within the period you selected before deducting discounts, promos, refunds, and return transactions.",
  },
  {
    "title": "Net Sales",
    "subtitle":
        "The revenue earned from sales transactions at outlets within the period you selected after deducting discounts, promos, and return transactions.",
  },
  {
    "title": "Gross Profit",
    "subtitle":
        "Total capital (Cost of Goods Sold) incurred and total profit (Gross Profit) obtained along with the percentage of total income (Net Sales) for outlets within the period you selected.",
  }
];

final icons = [
  Icons.account_circle,
  Icons.dashboard,
  Icons.settings,
];

final colors = [
  Colors.blue[200],
  Colors.green[200],
  Colors.red[200],
];

class TgPageWellcome extends StatelessWidget {
  const TgPageWellcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 500,
          ),
          child: Column(
            children: [
              Flexible(
                child: PageView(
                  children: [
                    for (final li in wellcomes)
                      Stack(
                        children: [
                          SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.asset(
                                "assets/images/bg_wellcome.png",
                                fit: BoxFit.cover,
                              )),
                          Container(
                            color: Colors.black12,
                            child: Column(
                              children: [
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        icons[wellcomes.indexOf(li)],
                                        size: 100,
                                        color: Colors.white,
                                      ),
                                      SizedBox(height: 40),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          li["title"]!.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey[50],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(24),
                                        child: Text(
                                          li["subtitle"]!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.blueGrey[50],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                    visible: wellcomes.indexOf(li) == 2,
                                    child: Center(
                                      child: MaterialButton(
                                          child: Text(
                                            "NEXT",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueGrey[50],
                                            ),
                                          ),
                                          onPressed: () {
                                            TgUtilPref.wellcome(value: false);
                                            TgUtilRouter.root().goOff();
                                          }),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              // Container(
              //   color: Colors.blueGrey[800],
              //   child: MaterialButton(
              //     color: Colors.blueGrey[800],
              //     onPressed: () {
              //       print("ini ada dimana");
              //       TgUtilPref.wellcome(value: false);
              //       TgRouter.root().goOff();
              //     },
              //     child: Container(
              //       padding: EdgeInsets.all(12),
              //       child: Center(
              //         child: Text(
              //           "NEXT",
              //           style: TextStyle(
              //             color: Colors.blueGrey[50],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      )),
    );
  }
}
