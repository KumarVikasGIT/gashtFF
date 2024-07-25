import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:images_picker/images_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? path;

  @override
  void initState() {
    super.initState();
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
            ElevatedButton(
              child: const Text('pick'),
              onPressed: () async {
                List<Media>? res = await ImagesPicker.pick(
                  count: 3,
                  pickType: PickType.all,
                  language: Language.System,
                  maxTime: 30,
                  // maxSize: 500,
                  cropOpt: CropOption(
                    // aspectRatio: CropAspectRatio.wh16x9,
                    cropType: CropType.circle,
                  ),
                );
                print(res);
                if (res != null) {
                  print(res.map((e) => e.path).toList());
                  setState(() {
                    path = res[0].thumbPath;
                  });
                  // bool status = await ImagesPicker.saveImageToAlbum(File(res[0]?.path));
                  // print(status);
                }
              },
            ),
            ElevatedButton(
              child: const Text('openCamera'),
              onPressed: () async {
                List<Media>? res = await ImagesPicker.openCamera(
                  // pickType: PickType.video,
                  pickType: PickType.image,
                  quality: 0.8,
                  maxSize: 800,
                  // cropOpt: CropOption(
                  //   aspectRatio: CropAspectRatio.wh16x9,
                  // ),
                  maxTime: 15,
                );
                print(res);
                if (res != null) {
                  print(res[0].path);
                  setState(() {
                    path = res[0].thumbPath;
                  });
                }
              },
            ),
            ElevatedButton(
              onPressed: () async {
                File file =
                await downloadFile('https://cdn.chavesgu.com/logo.png');
                bool res = await ImagesPicker.saveImageToAlbum(file,
                    albumName: "chaves");
                print(res);
              },
              child: const Text('saveNetworkImageToAlbum'),
            ),
            ElevatedButton(
              onPressed: () async {
                File file = await downloadFile(
                    'https://cdn.chavesgu.com/SampleVideo.mp4');
                bool res = await ImagesPicker.saveVideoToAlbum(file,
                    albumName: "chaves");
                print(res);
              },
              child: const Text('saveNetworkVideoToAlbum'),
            ),
            path != null
                ? SizedBox(
              height: 200,
              child: Image.file(
                File(path!),
                fit: BoxFit.contain,
              ),
            )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Future<File> downloadFile(String url) async {
    Dio simple = Dio();
    String savePath = '${Directory.systemTemp.path}/${url.split('/').last}';
    await simple.download(url, savePath,
        options: Options(responseType: ResponseType.bytes));
    debugPrint(savePath);
    File file = File(savePath);
    return file;
  }
}