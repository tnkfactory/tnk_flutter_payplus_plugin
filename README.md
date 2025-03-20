# 티앤케이팩토리 혜택플러스 flutter plugin

티앤케이팩토리 혜택플러스 flutter plugin 입니다.

카카오 페이포인트와 연계된 보상형 오퍼월 기능이 개발되었습니다. 커스터 스키마 적용과 간단한 SDK 함수 호출을 통해 보상형 광고 화면이 노출 가능합니다.

## tnk_flutter_payplus_plugin 설치 안내

1) Tnk 사이트에서 앱 등록 및 매체 정보 등록

2) 앱 내에 Tnk 충전소로 이동하는 버튼 구현

## 앱 등록 및 매체 정보 등록

다음 절차에 따라 회원 가입 후 광고 매체를 등록합니다.

[1. 회원가입](https://tnkfactory.github.io/docs/join)

[2. 매체 등록 및 app id발급방법](https://tnkfactory.github.io/incentive/APP%20ID)

## Installation

프로젝트의 IDE루트 경로에서 터미널을 열고 다음과 같이 실행하여 플러그인을 설치합니다.

```
flutter pub add tnk_flutter_payplus_plugin
```

## 개발 안내

아래 AOS, IOS 가이드문서에때라  프로젝트 기본 설정은 완료하시고 광고 목록을 띄우시길 바랍니다.

[안드로이드 가이드](https://github.com/tnkfactory/tnk_flutter_payplus_plugin/blob/main/AOS_GUIDE.md)

[iOS 가이드](https://github.com/tnkfactory/tnk_flutter_payplus_plugin/blob/main/IOS_GUIDE.md)

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
