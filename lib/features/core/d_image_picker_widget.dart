import 'package:datex/features/core/d_color.dart';
import 'package:datex/features/core/d_text_style.dart';
import 'package:datex/utils/dio_client.dart';
import 'package:datex/utils/injectable/configurator.dart';
import 'package:datex/utils/remote_constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class DPhotoPickerWidget extends StatefulWidget {
  final Function(File file) onImagePicked;
  const DPhotoPickerWidget({super.key, required this.onImagePicked});

  @override
  _DPhotoPickerWidgetState createState() => _DPhotoPickerWidgetState();
}

class _DPhotoPickerWidgetState extends State<DPhotoPickerWidget> {
  File? _image;
  // bool _isUploading = false;

  Future<void> _pickImage() async {
    if (await _requestPermission(Permission.photos)) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          widget.onImagePicked(_image!);
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
          widget.onImagePicked(_image!);
        });
      }
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.request();
    return status == PermissionStatus.granted;
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
                title: const Text('Выбрать из галереи'),
                onTap: () {
                  _pickImage();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Сделать фото'),
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

class DProfilePhotoPickerWidget extends StatefulWidget {
  final Function(File file) onImagePicked;
  final String? imageId;

  const DProfilePhotoPickerWidget({super.key, required this.onImagePicked, required this.imageId});

  @override
  _DProfilePhotoPickerWidgetState createState() => _DProfilePhotoPickerWidgetState();
}

class _DProfilePhotoPickerWidgetState extends State<DProfilePhotoPickerWidget> {
  File? _image;

  Future<void> _pickImage() async {
    if (await _requestPermission(Permission.photos)) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          widget.onImagePicked(_image!);
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
          widget.onImagePicked(_image!);
        });
      }
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.request();
    return status == PermissionStatus.granted;
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
                title: const Text('Выбрать из галереи'),
                onTap: () {
                  _pickImage();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Сделать фото'),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Круглая область под фото
        GestureDetector(
          onTap: _showImageSourceActionSheet, // При нажатии — выбор источника
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            // Если фото нет, оставляем дефолтный фон.
            // Если есть, показываем через backgroundImage.
            backgroundImage: _image == null
                ? widget.imageId != null
                    ? NetworkImage('${RemoteConstants.baseUrl}/upload/uploads/${widget.imageId}')
                    : null
                : FileImage(_image!),
            child: _image == null
                ? widget.imageId != null
                    ? const SizedBox()
                    : const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white70,
                      )
                : null,
          ),
        ),
        const SizedBox(height: 16),
        // Кнопка «Добавьте фото»
        InkWell(
          onTap: _showImageSourceActionSheet,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: DColor.greenColor)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Добавьте фото',
                style: DTextStyle.primaryText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
