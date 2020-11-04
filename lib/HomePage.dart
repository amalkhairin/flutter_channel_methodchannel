import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var platformMethodChannel = MethodChannel('native-channel');
  String _recentActivity = "";

  _openFromNative(String message) async {
    try {
      String result = await platformMethodChannel.invokeMethod(message);
      setState(() {
        _recentActivity = result;
      });
    } on PlatformException catch (e) {
      setState(() {
        _recentActivity = "error: ${e.message}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton.icon(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async {
                  await _openFromNative("open_camera");
                },
                icon: Icon(Icons.camera_alt, color: Colors.white,),
                label: Text("Open Camera")
              ),
              RaisedButton.icon(
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () async {
                  await _openFromNative("open_call");
                },
                icon: Icon(Icons.call, color: Colors.white,),
                label: Text("Open Call")
              ),
              SizedBox(height: 16.0,),
              Text("Recent Activity: $_recentActivity"),
            ],
          ),
        ),
      ),
    );
  }
}