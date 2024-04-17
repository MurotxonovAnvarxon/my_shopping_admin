import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? image;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();


  Future<void> uploadImageToFirebase(File image, String firebaseStoragePath) async {
    try {
      // Firebase Storage ni olish
      final storage = FirebaseStorage.instance;

      // Rasmni yuklash uchun StorageReference obyektini olish
      final ref = storage.ref().child(firebaseStoragePath);

      // Rasmni yuklash
      await ref.putFile(image);

      // Yuklab olingan rasm URL sini olish
      String downloadURL = await ref.getDownloadURL();
      print("Rasm muvaffaqiyatli yuklandi. URL: $downloadURL");
    } catch (e) {
      print("Rasmni yuklashda xatolik yuz berdi: $e");
    }
  }


  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
//koment
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
          SizedBox(
            height: 200,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: pickImage,
                  child: const Text('Rasm tanlang'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: image == null
                        ? const Center(
                            child: Text(
                              'No image',
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        : AspectRatio(
                            aspectRatio: 1,
                            child: Image.file(
                              image!,
                              height: 300,
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              onChanged: (text) {
                controllerName.text = text;
              },
              controller: controllerName,
              decoration: const InputDecoration(
                labelText: "Product name",
                hintText: "Product name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              onChanged: (text) {
                controllerDescription.text = text;
              },
              controller: controllerDescription,
              decoration: const InputDecoration(
                labelText: "Product description",
                hintText: "Product description",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              onChanged: (text) {
                controllerPrice.text = text;
              },
              controller: controllerPrice,
              decoration: const InputDecoration(
                labelText: "Product price",
                hintText: "Product price",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            onPressed: ()async {
              // File? image = await pickImage();

              uploadImageToFirebase(image!, "images/${DateTime.now().millisecondsSinceEpoch}.jpg");

            },
            child: Text("save"),
          )
        ],
      ),
    );
  }
}
