package com.example.flutter_channel_camera

import android.content.Intent
import android.net.Uri
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val CHANNEL: String = "native-channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler{ call, result ->
                    when(call.method){
                        "open_camera" -> {
                            val intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
                            startActivity(intent)
                            result.success("Camera")
                        }

                        "open_call" -> {
                            val intent = Intent(Intent.ACTION_DIAL, Uri.parse("tel:0012345"))
                            startActivity(intent)
                            result.success("Dial")
                        }
                    }
                }
    }
}
