import 'package:flutter/material.dart';
import 'package:get/get.dart';

class V2DashboadItemCard extends StatelessWidget {
  const V2DashboadItemCard(
      {Key? key,
      required this.bgColor,
      required this.billValue,
      required this.onDetail,
      required this.title,
      required this.titleIcon,
      required this.value,
      required this.heroTag1})
      : super(key: key);

  final Color bgColor;
  final IconData titleIcon;
  final String title;
  final VoidCallback onDetail;
  final String value;
  final String billValue;
  final String heroTag1;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Container(
        height: 200,
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/dashboard_item.png',
                ))),
        child: Stack(
          children: [
            Container(
              width: Get.width,
              color: bgColor.withOpacity(0.9),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset('assets/images/food_item1.png'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: heroTag1,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                backgroundColor: Colors.white70,
                                child: Icon(
                                  titleIcon,
                                  size: 32,
                                  color: Colors.green,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              title,
                              style:
                                  TextStyle(color: Colors.white70, fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: onDetail,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.yellow,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4, bottom: 4, left: 16, right: 16),
                          child: Text("Detail"),
                        ),
                      ),
                    )
                  ],
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          value,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 42),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.black38,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                            backgroundColor: Colors.white70,
                            child: Icon(
                              Icons.event_note_rounded,
                              color: Colors.black38,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          billValue,
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
