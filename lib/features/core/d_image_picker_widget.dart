import 'package:datex/utils/dio_client.dart';
import 'package:datex/utils/injectable/configurator.dart';
import 'package:datex/utils/remote_constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class DPhotoPickerWidget extends StatefulWidget {
  final Function(String url) onImagePicked;
  const DPhotoPickerWidget({super.key, required this.onImagePicked});

  @override
  _DPhotoPickerWidgetState createState() => _DPhotoPickerWidgetState();
}

class _DPhotoPickerWidgetState extends State<DPhotoPickerWidget> {
  File? _image;
  bool _isUploading = false;

  Future<void> _pickImage() async {
    if (await _requestPermission(Permission.photos)) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }
  }

  Future<void> _takePhoto() async {
    if (await _requestPermission(Permission.camera)) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.request();
    return status == PermissionStatus.granted;
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      _showMessage('Please select an image first.');
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      DioClient dio = getIt.get<DioClient>();
      ;
      String fileName = _image!.path.split('/').last;

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          _image!.path,
          filename: fileName,
        ),
      });

      Response response = await dio.post(
        "${RemoteConstants.baseUrl}/upload", // Укажи URL своего бэкенда
        data: formData,
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
        }),
      );

      // print(re)

      if (response.statusCode == 200) {
        _showMessage("Upload successful: ${response.data}");
      } else {
        _showMessage("Upload failed: ${response.statusMessage}");
      }
    } catch (e) {
      _showMessage("Error: $e");
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: _showImageSourceActionSheet,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _image == null ? const Icon(Icons.add, size: 25) : Image.file(_image!, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 20),
        _isUploading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _uploadImage,
                child: const Text("Upload Image"),
              ),
      ],
    );
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  _pickImage();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  _takePhoto();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
