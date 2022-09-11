// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unused_field, avoid_print, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:modern_form_esys_flutter_share/modern_form_esys_flutter_share.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static GlobalKey previewContainer = GlobalKey();

  //   void _launchURL() async {
  //   String _url = 'https://wa.me/+919885071155';

  //   if (!await launch(_url)) throw 'Could not launch $_url';
  // }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: previewContainer,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            color: Colors.red,
            height: 30,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    final RenderRepaintBoundary imageObject =
                        previewContainer.currentContext!.findRenderObject()!
                            as RenderRepaintBoundary;
                    final image = await imageObject.toImage(pixelRatio: 2);
                    ByteData? byteData =
                        await image.toByteData(format: ui.ImageByteFormat.png);
                    Uint8List pngBytes = byteData!.buffer.asUint8List();
                    final base64String = base64Encode(pngBytes);

                    await Share.file(
                        'esys image', 'esys.png', pngBytes, 'image/png',
                        text: 'My optional text.');
                  },
                  child: const Text('Take a Screenshot'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            share();
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  takeScreenShot() async {
    final RenderRepaintBoundary boundary = previewContainer.currentContext!
        .findRenderObject()! as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    print(pngBytes);
    File imgFile = File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes);
  }

  void share() async {
    final RenderRepaintBoundary imageObject = previewContainer.currentContext!
        .findRenderObject()! as RenderRepaintBoundary;
    final image = await imageObject.toImage(pixelRatio: 2);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    final base64String = base64Encode(pngBytes);

    await Share.file('esys image', 'esys.png', pngBytes, 'image/png',
        text: 'My optional text.');
  }
}
