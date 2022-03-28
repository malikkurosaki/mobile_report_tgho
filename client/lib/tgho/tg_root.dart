import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_report/tgho/tg_util_router.dart';
import 'package:mobile_report/tgho/tg_util_pref.dart';

class TgRoot extends StatelessWidget {
  const TgRoot({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onLoad();
    return Material(
      child: SafeArea(
        child: Center(
          child: Text("loading ..."),
        )
      ),
    );
  }

  onLoad()async{
    await 0.1.delay();

    TgUtilPref.wellcome();
    TgUtilPref.user();

    if(TgUtilPref.wellcomeX.value){
      TgUtilRouter.wellcome().goOff();
      return;
    }

    if(TgUtilPref.userX.isEmpty){
      TgUtilRouter.login().goOff();
      return;
    }

    TgUtilRouter.dashboard().goOff();
  }
}