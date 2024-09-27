import 'dart:convert';
import 'dart:io';

import 'package:api_services/providers/usermodalprovider.dart';
import 'package:api_services/screens/userscreen.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserModalProvider>(
          create: (_) => UserModalProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dio = Dio();

  dynamic filepath;
  bool isUploading = false;
  String? uploadedFileUrl;
  String? imageUrl;
  bool isFetching = false;

  Future<void> postApi(String filepath) async {
    try {
      setState(() {
        isUploading = true;
      });

      // Create the form data with the file to be uploaded
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filepath,
            filename: filepath.split('/').last),
      });

      // Send the POST request
      var response = await dio.post(
        "https://api.escuelajs.co/api/v1/files/upload",
        data: formData,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data', // Specify content type
        }),
      );

      if (response.statusCode == 201) {
        // Successfully uploaded
        print("File upload failed:12 ${response.data['location']}");
        setState(() {
          uploadedFileUrl = response.data['location'];

          isUploading = false;
        });
      } else {
        setState(() {
          isUploading = false;
        });
      }
    } catch (e) {
      setState(() {
        isUploading = false;
      });
      print("Error uploading file: $e");
    }
  }

  Future<void> getImage(path) async {
    try {
      setState(() {
        isFetching = true;
      });

      // Perform the GET request
      Response response = await dio.get(
        path, // Use the URL from the TextField
        options: Options(
          responseType: ResponseType.stream, // Important for image files
        ),
      );
      var v = jsonDecode(response.data['location']);
      debugPrint("jvhdfnm$v");
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      print("Error fetching image: $e");
    } finally {
      setState(() {
        isFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (filepath != null)
              Image.file(
                File(filepath),
                height: 200,
                width: 200,
              ),
            if (uploadedFileUrl != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Uploaded File URL: $uploadedFileUrl"),
              ),
            // if (imageUrl != null)
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Image.network(imageUrl!, height: 200, width: 200),
            //   ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: const Text("Pick and Upload Image"),
              onTap: () async {
                // Pick a file
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                if (result != null && result.files.isNotEmpty) {
                  setState(() {
                    filepath = result.files.first.path;
                  });

                  // Upload the picked file
                  if (filepath != null) {
                    await postApi(filepath!);
                  }
                }
              },
            ),
            if (isUploading) const CircularProgressIndicator(),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: const Text("Fetch Image"),
              onTap: () async {
                await getImage(
                    "https://api.escuelajs.co/api/v1/files/55e2.jpg");
              },
            ),
            if (isFetching) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
