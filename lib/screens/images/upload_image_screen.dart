import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twenty_five_flutter_api/get/images_getx_controller.dart';
import 'package:twenty_five_flutter_api/models/student_image.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  double? _progressValue = 0;
  late ImagePicker _imagePicker;
  XFile? _pickedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Images'),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: _progressValue,
            color: Colors.green,
            backgroundColor: Colors.grey.shade400,
            minHeight: 6,
          ),
          Expanded(
            child: _pickedFile != null
                ? Image.file(File(_pickedFile!.path))
                : TextButton(
                    onPressed: () async => pickImage(),
                    child: Text(
                      'Select Image',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, 0),
                    ),
                  ),
          ),
          ElevatedButton.icon(
            onPressed: () async => uploadImage(),
            icon: Icon(Icons.cloud_upload),
            label: Text('Upload Image'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future pickImage() async {
    _imagePicker = ImagePicker();
    XFile? selectedImageFile = await _imagePicker.pickImage(
        source: ImageSource.gallery); // هنا ماذا سوف تختار صورة او الخ
    if (selectedImageFile != null) {
      // اذا الصورة التي يتم اختيارها مش null يروح يعمل setState على _pickedFile
      setState(() {
        _pickedFile = selectedImageFile;
      });
    }
  }

  Future uploadImage() async {
    _changeProgressValue(value: null);
    if (_pickedFile != null) {
      ImagesGetxController.to.upload(
        filePath: _pickedFile!.path,
        imageUploadResponse: (
            {required String massage,
            required bool status,
            StudentImage? studentImage}) {
           _changeProgressValue(value: status ? 1 : 0);
           if(status) _clearSelectedImage();
        },
      );
    }
  }

  void _changeProgressValue({double? value}){
    setState(() {
      _progressValue = value;
    });
  }

  void _clearSelectedImage(){
    setState(() {
      _pickedFile = null;
    });
  }

}
