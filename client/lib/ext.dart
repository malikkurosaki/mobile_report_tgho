import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension Textputih on Text {
  Text txtMenu() {
    return Text(
      data!,
      style:
          TextStyle(color: Color.fromARGB(255, 51, 51, 51), fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  txtMenuBold() => Text(
        data!,
        style: TextStyle(
          color: Color.fromARGB(255, 70, 70, 70),
          fontSize: 16,
        ),
      );
}
