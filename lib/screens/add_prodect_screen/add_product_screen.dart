import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: const Center(
          child: Text(
            "Decoration Shop",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Rasm tanlanmagan'),
                ),
                Expanded(
                  child: _image == null
                      ? const Center(
                    child: Text(
                      'No image',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                      : Image.file(
                    _image!,
                    height: 60,
                    width: 400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
