
import 'tnk_flutter_payplus_plugin_platform_interface.dart';

class TnkFlutterPayplusPlugin {
  Future<String?> getPlatformVersion() {
    return TnkFlutterPayplusPluginPlatform.instance.getPlatformVersion();
  }

  Future<String?> showOfferwall(Map<String,String> argsMap ) {
    return TnkFlutterPayplusPluginPlatform.instance.showOfferwall(argsMap);
  }

  Future<String?> setCOPPA(bool coppa) {
    return TnkFlutterPayplusPluginPlatform.instance.setCOPPA(coppa);
  }

  Future<String?> showATTPopup() {
    return TnkFlutterPayplusPluginPlatform.instance.showATTPopup();
  }
}
