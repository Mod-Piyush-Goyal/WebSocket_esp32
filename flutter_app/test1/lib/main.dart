import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String esp32WebSocketUrl = "ws://192.168.137.157:81/";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebSocketDemo(url: esp32WebSocketUrl),
    );
  }
}

class WebSocketDemo extends StatefulWidget {
  final String url;
  WebSocketDemo({required this.url});

  @override
  _WebSocketDemoState createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  late WebSocketChannel channel;
  String receivedData = "No Data Yet";

  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(Uri.parse(widget.url));

    channel.stream.listen((message) {
      setState(() {
        receivedData = message;
      });
    }, onError: (error) {
      print("WebSocket Error: $error");
    }, onDone: () {
      print("WebSocket Disconnected.");
    });
  }

  void sendMessage() {
    channel.sink.add("This is piyush my first websocket message");
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ESP32 WebSocket Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Received from ESP32:"),
            Text(receivedData, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendMessage,
              child: Text("Send Message"),
            ),
          ],
        ),
      ),
    );
  }
}
