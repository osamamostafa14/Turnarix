package com.turnarix.app

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback

public class Application: FlutterApplication(), PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
      //  FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry) {

    }
}