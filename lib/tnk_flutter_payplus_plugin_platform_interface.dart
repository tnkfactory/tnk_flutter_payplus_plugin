import 'dart:collection';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tnk_flutter_payplus_plugin_method_channel.dart';

abstract class TnkFlutterPayplusPluginPlatform extends PlatformInterface {
  /// Constructs a TnkFlutterPayplusPluginPlatform.
  TnkFlutterPayplusPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static TnkFlutterPayplusPluginPlatform _instance = MethodChannelTnkFlutterPayplusPlugin();

  /// The default instance of [TnkFlutterPayplusPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelTnkFlutterPayplusPlugin].
  static TnkFlutterPayplusPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TnkFlutterPayplusPluginPlatform] when
  /// they register themselves.
  static set instance(TnkFlutterPayplusPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> showOfferwall(Map<String, String> argsMap) {
    throw UnimplementedError('showOfferwall() has not been implemented.');
  }

  Future<String?> setCOPPA(bool coppa) {
    throw UnimplementedError('showAdList() has not been implemented.');
  }

  Future<String?> showATTPopup() {
    throw UnimplementedError('showATTPopup() has not been implemented.');
  }
}
