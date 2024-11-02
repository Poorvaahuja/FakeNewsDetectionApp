import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class FakeNewsPage extends StatefulWidget {
  @override
  _FakeNewsPageState createState() => _FakeNewsPageState();
}

class _FakeNewsPageState extends State<FakeNewsPage>{
  TextEditingController _headlineController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  String _result = '';

  Future<void> _predict() async {
    String text = "${_headlineController.text} ${_bodyController.text}";

    var input = await preprocessText(text);
    var byteInput = Uint8List.fromList(input.map((e) => e.toInt()).toList());
    var predictions = await Tflite.runModelOnBinary(
      binary: byteInput,
    );
    setState(() {
      _result = (predictions?[0]["confidence"] > 0.5) ? "Real" : "Fake";
    });
  }

    Future<List<double>> preprocessText(String text) async {
  // Implement text preprocessing similar to training here.
  // You may need to perform tokenization, padding, etc., manually.
  // For demonstration, we assume preprocessing is complete.
    return [/* Processed input */];
  }
  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(title: Text("Fake News Detector")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _headlineController,
              decoration: InputDecoration(labelText: "Headline"),
            ),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(labelText: "Body"),
            ),
            ElevatedButton(
              onPressed: _predict,
              child: Text("Check News"),
            ),
            Text("Result: $_result"),
          ],
        ),
      ),
    );
  }
}

