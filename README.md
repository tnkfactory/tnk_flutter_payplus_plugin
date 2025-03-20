# tnk_flutter_payplus_plugin

티앤케이팩토리 혜택플러스 flutter plugin 입니다.

TnkAd SDK는 Tnk의 광고 네트워크 상에서 광고앱 이나 매체앱을 개발하기 위하여 제공되는 통합된 SDK이며 아래의 기능들을 사용하실 수 있습니다.

보상형/구매형 광고의 오퍼월(Offer-wall)
분석도구(Analytics) 기능 제공으로 유입경로 별 앱사용율, 재방문율, 퍼널분석 등의 다양한 분석보고서 생성

## 개발 안내

아래 aos, ios 가이드문서에때라  프로젝트 기본 설정은 완료하시고 광고 목록을 띄우시길 바랍니다.

[안드로이드 가이드](https://github.com/tnkfactory/tnk_flutter_rwd_plugin/blob/master/guide_android.md)

[iOS 가이드](https://github.com/tnkfactory/tnk_flutter_rwd_plugin/blob/master/guide_ios.md)

위와같은 과정을 마치고 나면 플러터 프로젝트에서 광고 페이지를 호출 하실 수 있습니다.

### 광고 목록 띄우기

<u>테스트 상태에서는 테스트하는 장비를 개발 장비로 등록하셔야 광고목록이 정상적으로 나타납니다.</u>

[테스트 단말기 등록하는 방법](https://tnkfactory.github.io/incentive/reg_test_device)

다음과 같이 호출하여 광고 목록을 출력 하실 수 있습니다.

```dart
import 'package:tnk_flutter_payplus_plugin/tnk_flutter_payplus_plugin.dart';

// ...
// ...

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _offerwallResult = 'Unknown';
  final _tnkFlutterPayplusPlugin = TnkFlutterPayplusPlugin();

  static const AOS_SCHEME = "AOS_SCHEME";
  static const IOS_SCHEME = "IOS_SCHEME";
  static const AOS_APP_ID = "AOS_APP_ID";
  static const IOS_APP_ID = "IOS_APP_ID";

  Future<void> showOfferwall() async {
    String result;
    try {

      // await _tnkFlutterPayplusPlugin.showATTPopup(); // optional 광고추적허용

      // 연령에 맞는 광고가 보일 수 있도록 아래의 옵션을 설정하시기 바랍니다.
      await _tnkFlutterPayplusPlugin.setCOPPA(false); // true : 13세 미만, false : 13세 이상

      HashMap<String,String> param = HashMap();
      
      // map의 key 값은 아래와같이 꼭 설정해주셔야 합니다.
      param.addAll(
        {
          AOS_SCHEME: "tnkrwd{aos매체아이디}",
          IOS_SCHEME: "tnkrwd{ios매체아이디}",
          AOS_APP_ID: "${aos_tnk_app_id}",
          IOS_APP_ID: "${ios_tnk_app_id}"
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
    
    
    // ...
    // ...
    // ...
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
                  onPressed: () => showOfferwall("tnkrwd{매체아이디}", "", "${tnk_app_id}"),
                  child: Text('Show Offerwall'),
                ),
              ],
            )
        ),
      ),
    );
  }
  // ...
  // ...
}
