import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../themes/app_colors.dart';

class MlPage extends StatefulWidget {
  const MlPage({Key? key}) : super(key: key);

  @override
  State<MlPage> createState() => _MlPageState();
}

class _MlPageState extends State<MlPage> {
  Interpreter? interpreter;
  File? _image;
  late ImagePicker _imagePicker;
  List<String>? _labels;
  String? _recognitionResult;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    loadModel();
    loadLabels();
  }

  Future<void> loadModel() async {
    interpreter = await Interpreter.fromAsset('assets/trashdetection.tflite');
  }

  Future<void> loadLabels() async {
    try {
      String labelsContent = await rootBundle.loadString('assets/trashdetection.txt');
      _labels = labelsContent.split('\n');
    } catch (e) {
      print('Error loading labels: $e');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      detectObjects();
    }
  }

  Future<void> detectObjects() async {
    if (interpreter == null || _image == null || _labels == null) {
      return;
    }

    try {
      final Uint8List imageBytes = await _image!.readAsBytes();
      final inputShape = interpreter!.getInputTensor(0)!.shape;
      final outputList = List.generate(
        inputShape[0],
        (index) => List.filled(inputShape[1], 0, growable: false),
        growable: false,
      );

      interpreter!.run(
        imageBytes.buffer.asUint8List(),
        outputList,
      );

      int maxIndex = outputList[0].indexOf(outputList[0].reduce(max)); 

      setState(() {
        _recognitionResult = _labels![maxIndex];
      });
    } catch (e) {
      print('Error detecting objects: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Trace2Treat',
        home: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.primary,
            title: const Text('Detection', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _image == null
                      ? Text('Pilih gambar untuk deteksi objek')
                      : Container(
                          height: 300, // Adjust the height as needed
                          child: Image.file(_image!),
                        ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Pilih Gambar'),
                  ),
                  SizedBox(height: 20),
                  if (_recognitionResult != null)
                    Text('Hasil deteksi: $_recognitionResult'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}