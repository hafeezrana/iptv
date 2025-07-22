package com.iptv.azul

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "main_activity_channel"
    private val GDPR_CHANNEL = "gdpr_plugin"
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Set up the GDPR plugin channel
        flutterEngine?.dartExecutor?.let {
            MethodChannel(it.binaryMessenger, GDPR_CHANNEL).setMethodCallHandler(
                GdprPlugin(this)
            )
        }
        
        // Set up the main activity channel
        flutterEngine?.dartExecutor?.let {
            MethodChannel(it.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
                if (call.method == "getData") {
                    val dd = resources.getString(R.string.unique_key)
                    result.success(dd)
                } else {
                    result.notImplemented()
                }
            }
        }
    }
}