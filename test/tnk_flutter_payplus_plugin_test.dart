import 'package:flutter_test/flutter_test.dart';
import 'package:tnk_flutter_payplus_plugin/tnk_flutter_payplus_plugin.dart';
import 'package:tnk_flutter_payplus_plugin/tnk_flutter_payplus_plugin_platform_interface.dart';
import 'package:tnk_flutter_payplus_plugin/tnk_flutter_payplus_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTnkFlutterPayplusPluginPlatform
    with MockPlatformInterfaceMixin
    implements TnkFlutterPayplusPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> setCOPPA(bool coppa) {
    // TODO: implement setCOPPA
    throw UnimplementedError();
  }

  @override
  Future<String?> showATTPopup() {
    // TODO: implement showATTPopup
    throw UnimplementedError();
  }

  @override
  Future<String?> showOfferwall(Map<String,String> argsMap) {
    // TODO: implement showOfferwall
    throw UnimplementedError();
  }
}

void main() {
  final TnkFlutterPayplusPluginPlatform initialPlatform = TnkFlutterPayplusPluginPlatform.instance;

  test('$MethodChannelTnkFlutterPayplusPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTnkFlutterPayplusPlugin>());
  });

  test('getPlatformVersion', () async {
    TnkFlutterPayplusPlugin tnkFlutterPayplusPlugin = TnkFlutterPayplusPlugin();
    MockTnkFlutterPayplusPluginPlatform fakePlatform = MockTnkFlutterPayplusPluginPlatform();
    TnkFlutterPayplusPluginPlatform.instance = fakePlatform;

    expect(await tnkFlutterPayplusPlugin.getPlatformVersion(), '42');
  });
}
