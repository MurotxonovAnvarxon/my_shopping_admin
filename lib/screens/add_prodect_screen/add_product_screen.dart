import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_shopping_admin/product_data/product_data.dart';

import '../../service.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? image;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();

  String imageUrl = ''; // Set the actual image URL here

  String generateUniqueId() {
    return FirebaseFirestore.instance.collection('productsLast').doc().id;
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Adjust as needed
      ),
    );
  }

  Future uploadImage(String path) async {
    try {
      if (image != null) {
        final ref = FirebaseStorage.instance.ref().child('images/${path}.png');
        final uploadTask = ref.putFile(image!);
        await uploadTask.whenComplete(() => null);
        print('Image uploaded to Firebase Storage successfully.');
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> uploadFirestore(
    String id,
    String imagePath,
    String productName,
    String productDescription,
    String productPrice,
    String productCategories,
  ) async {
    try {
      if (image == null) {
        print('No image selected.');
        return; // Exit function if no image is selected
      }
      await FirebaseFirestore.instance.collection('productLast').add({
        'id': id,
        'productName': productName,
        'productDescription': productDescription,
        'imageUrl': imageUrl,
        'productPrice': productPrice,
        'productCategories': productCategories,
        'storagePath': imagePath,
      });

      print('Image uploaded to Firebase Storage and Firestore successfully.');
    } catch (e) {
      print('Error uploading image: $e');
      // Handle error, display error message, or notify user accordingly
    }
  }

  void addProduct(
    String id,
    String imagePath,
    String name,
    String description,
    String price,
    String categoriesName,
  ) async {
    await ProductService.addProductToFirestore(
      id: id,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
      isAvailable: true,
      categoriesName: categoriesName,
    );
  }

  String selectedCategory = 'None';

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

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'None',
      'Stullar',
      'Stollar',
      'Dekoratsiya'
    ];
    String dropdownValue = categories.first;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: const Text(
          "Decoration Shop",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        primary: true,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: InkWell(
                onTap: () {
                  pickImage();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 1)),
                  height: MediaQuery.of(context).size.width / 2,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: image == null
                            ? const Center(
                                child: Text(
                                  'Rasm tanlang',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
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
                    ],
                  ),
                ),
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
                  labelText: "Dekoratsiya nomi",
                  hintText: "Dekoratsiya nomi",
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
                  labelText: "Dekoratsiya matni",
                  hintText: "Dekoratsiya matni",
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
                keyboardType: TextInputType.number,
                controller: controllerPrice,
                decoration: const InputDecoration(
                  labelText: "Dekoratsiya narxi",
                  hintText: "Dekoratsiya narxi",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InputDecorator(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    isDense: true,
                    underline: Container(
                      color: Colors.black,
                      width: 20,
                      height: 20,
                    ),
                    value: selectedCategory,
                    style: const TextStyle(color: Colors.black),
                    iconDisabledColor: Colors.black,
                    iconEnabledColor: Colors.black,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedCategory = newValue;
                        });
                      }
                    },
                    items: categories
                        .map<DropdownMenuItem<String>>((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () async {
                  if (selectedCategory == 'None') {
                    showSnackbar(context, 'Iltimos kategoriya tanlang!');
                  } else if (controllerName.text.length < 4) {
                    showSnackbar(context, "Nom uzunligi 4 dan katta bo'lsin");
                  } else if (controllerDescription.text.length < 4) {
                    showSnackbar(
                        context, "Deskription uzunligi 4 dan katta bo'lsin");
                  } else if (controllerPrice.text.isEmpty) {
                    showSnackbar(context, "Iltimos narxni kiriting");
                  } else {
                    var idAndPath = generateUniqueId();
                    uploadImage(idAndPath);
                    addProduct(
                        idAndPath + '.png',
                        idAndPath,
                        controllerName.text,
                        controllerDescription.text,
                        controllerPrice.text,
                        selectedCategory);

                    Navigator.pushNamed(context, "home");
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blueAccent),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        'Saqlash',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
