import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tnk_flutter_payplus_plugin/tnk_flutter_payplus_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _offerwallResult = 'Unknown';
  final _tnkFlutterPayplusPlugin = TnkFlutterPayplusPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _tnkFlutterPayplusPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  static const AOS_SCHEME = "AOS_SCHEME";
  static const IOS_SCHEME = "IOS_SCHEME";
  static const AOS_APP_ID = "AOS_APP_ID";
  static const IOS_APP_ID = "IOS_APP_ID";

  Future<void> showOfferwall() async {
    String result;
    try {


      // 앱 추적동의
      // await _tnkFlutterPayplusPlugin.showATTPopup(); // optional 광고추적허용

      // COPPA는 미국 어린이 온라인 개인정보 보호법 및 관련 법규입니다.
      // 구글 에서는 앱이 13세 미만의 아동을 대상으로 서비스한다면 관련 법률을 준수하도록 하고 있습니다.
      // 연령에 맞는 광고가 보일 수 있도록 아래의 옵션을 설정하시기 바랍니다.
      await _tnkFlutterPayplusPlugin.setCOPPA(false); // true : 13세 미만, false : 13세 이상

      HashMap<String,String> param = HashMap();
      param.addAll(
        {
          AOS_SCHEME: "tnkrwd667145",
          IOS_SCHEME: "tnkrwd667279",
          AOS_APP_ID: "40c070e0-d091-29a5-5a92-19030b080904",
          IOS_APP_ID: "60f07040-0001-29a5-5a91-1f0601090607"
        }
      );
      result = await _tnkFlutterPayplusPlugin.showOfferwall(param) ?? 'Unknown result';
    } on PlatformException catch(e) {
      print('Error code: ${e.code}');
      print('Error message: ${e.message}');

      result = 'error code : ${e.code}, error message : ${e.message}';
    }
    setState(() {
      _offerwallResult = result;
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child:
            Column(
              children: <Widget>[
                Text('Running on: $_platformVersion\n'),

                Text('offerwall: $_offerwallResult\n'),

                ElevatedButton(
                  onPressed: () => showOfferwall(),
                  child: Text('Show Offerwall'),
                ),
              ],

            )

        ),
      ),
    );
  }
}
