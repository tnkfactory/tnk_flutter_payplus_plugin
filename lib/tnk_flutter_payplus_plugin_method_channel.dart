import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tnk_flutter_payplus_plugin_platform_interface.dart';

/// An implementation of [TnkFlutterPayplusPluginPlatform] that uses method channels.
class MethodChannelTnkFlutterPayplusPlugin extends TnkFlutterPayplusPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tnk_flutter_payplus_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> showOfferwall(Map<String,String> argsMap) async {
    final result = await methodChannel.invokeMethod<String>('showOfferwall', <String, dynamic>{"map":argsMap});
    return result;
  }

  @override
  Future<String?> setCOPPA(bool coppa) async {
    final version = await methodChannel.invokeMethod<String>('setCOPPA', <String, dynamic>{"coppa":coppa});
    return version;
  }

  @override
  Future<String?> showATTPopup() async {
    final version = await methodChannel.invokeMethod<String>('showATTPopup');
    return version;
  }
}
