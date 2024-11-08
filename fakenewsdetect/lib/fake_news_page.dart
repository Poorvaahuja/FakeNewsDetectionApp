import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class FakeNewsPage extends StatefulWidget {
  @override
  _FakeNewsPageState createState() => _FakeNewsPageState();
}

class _FakeNewsPageState extends State<FakeNewsPage> {
  final TextEditingController _headlineController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  bool? _isFakeNews;

  late Interpreter _interpreter;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/fakenews.tflite');
  }

  Future<void> _predictFakeNews() async {
    // Combine headline and body text
    String inputText = "${_headlineController.text} ${_bodyController.text}";
    
    // Convert the input text into a format that the model understands
    List<double> inputList = _processInputText(inputText);

    // Set input and output tensors
    var inputTensor = TensorBuffer.createFixedSize([1, inputList.length], TfLiteType.float32);
    inputTensor.loadList(inputList, shape: [1,1]);

    // Prepare output buffer
    var outputTensor = TensorBuffer.createFixedSize([1, 1], TfLiteType.float32);

    // Run inference
    _interpreter.run(inputTensor.buffer, outputTensor.buffer);

    // Process and display result
    setState(() {
      _isFakeNews = outputTensor.getDoubleValue(0) > 0.5;
    });
  }

  // Example text processing function (to be customized)
  List<double> _processInputText(String text) {
    // Basic example of encoding text into numerical format (word counts, embeddings, etc.)
    // Customize based on how you trained your model, e.g., use tokenization, padding, etc.
    List<double> encodedText = text
        .split(' ')
        .map((word) => word.hashCode.toDouble())
        .toList();

    // Ensure the input size matches model requirements (padding or truncating)
    int requiredLength = 100; // Example input size, change as needed
    if (encodedText.length < requiredLength) {
      encodedText.addAll(List.filled(requiredLength - encodedText.length, 0));
    } else if (encodedText.length > requiredLength) {
      encodedText = encodedText.sublist(0, requiredLength);
    }

    return encodedText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fake News Detection")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _headlineController,
              decoration: InputDecoration(labelText: "Headline"),
            ),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(labelText: "Body"),
              maxLines: 5,
            ),
            ElevatedButton(
              onPressed: _predictFakeNews,
              child: Text("Predict"),
            ),
            if (_isFakeNews != null)
              Text(
                _isFakeNews! ? "Fake" : "Real",
                style: TextStyle(
                  fontSize: 20,
                  color: _isFakeNews! ? Colors.red : Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _headlineController.dispose();
    _bodyController.dispose();
    _interpreter.close();
    super.dispose();
  }
}
