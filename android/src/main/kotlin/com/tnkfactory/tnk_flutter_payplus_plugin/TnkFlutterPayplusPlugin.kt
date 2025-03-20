package com.tnkfactory.tnk_flutter_payplus_plugin

import android.app.Activity
import androidx.annotation.NonNull
import com.tnkfactory.ad.rwdplus.kakao.TnkRwdPlus
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** TnkFlutterPayplusPlugin */
class TnkFlutterPayplusPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var mActivity: Activity
    private lateinit var tnkRwdPlus: TnkRwdPlus

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "tnk_flutter_payplus_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        try {
            when (call.method) {
                "getPlatformVersion" -> {
                    result.success("Android ${android.os.Build.VERSION.RELEASE}")
                }

                "setCOPPA" -> {
                    tnkRwdPlus.setCOPPA(call.argument("coppa") as? Boolean ?: false)
                    result.success("success")
                }

                "showATTPopup" -> {
                    result.success("success")
                }

                "showOfferwall" -> {
                    val scheme = call.argument("scheme") as? String ?: ""
                    val param = call.argument("map") as? HashMap<String, String>
                    if( param != null ) {

                        tnkRwdPlus.setScheme(param["AOS_SCHEME"] as String)
                        tnkRwdPlus.showOfferwall(mActivity)
                        result.success("Offerwall shown")
                    } else {
                        result.error("-1", "data is required", null)
                    }
//                    if (scheme == "") {
//                        result.error("-1", "scheme is required", null)
//                    } else {
//                        tnkRwdPlus.setScheme(call.argument("scheme") as? String ?: "")
//                        tnkRwdPlus.showOfferwall(mActivity)
//                        result.success("Offerwall shown")
//                    }

                }


                else -> {
                    result.notImplemented()
                }

            }

        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        mActivity = binding.activity
        tnkRwdPlus = TnkRwdPlus(mActivity)
    }

    override fun onDetachedFromActivityForConfigChanges() {
//    TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
//    TODO("Not yet implemented")
    }

    override fun onDetachedFromActivity() {
//    TODO("Not yet implemented")
    }


}
