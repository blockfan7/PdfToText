import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pdf_text_package/pdf_text_package.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _pdfText = '';
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await PdfTextPackage.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            FlatButton(
              color: Colors.blueGrey,
              onPressed: () {
                FilePicker.getFile(
                        allowedExtensions: ["pdf"], type: FileType.custom)
                    .then((File file) async {
                  if (file.path.isNotEmpty) {
                    // Call the function to parse text from pdf
                    getPDFtext(file.path).then((String pdfText) {
                      final text = pdfText.replaceAll("\n", " ");
                      setState(() {
                        _pdfText = text;
                      });
                    });
                  }
                });
              },
              child: Text("Get pdf text"),
            ),
            Expanded(
              child: Text(
                "Result: $_pdfText",
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> getPDFtext(String path) async {
    String text = "";
    try {
      text = await PdfTextPackage.getPDFtext(path);
    } on PlatformException {
      text = 'Failed to get PDF text.';
    }
    return text;
  }
}
