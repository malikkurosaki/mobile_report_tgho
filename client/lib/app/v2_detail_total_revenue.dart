import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class V2DetailTotalRevenue extends StatelessWidget {
  const V2DetailTotalRevenue({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(),
            Flexible(
              child: ListView(
                children: [
                  Text("Detail Total Revenue")
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}