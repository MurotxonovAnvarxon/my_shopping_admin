import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../product_data/product_data.dart';

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

  String imageUrl = ''; // Set the actual image URL here

  // Function to generate a unique ID (e.g., using Firestore auto-generated ID)
  String generateUniqueId() {
    return FirebaseFirestore.instance.collection('products').doc().id;
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Adjust as needed
      ),
    );
  }

  // Function to add product to Firestore
  Future<void> addProductToFirestore() async {
    try {
      String productId = generateUniqueId();

      // Create a Product instance with the entered data
      Product newProduct = Product(
          id: productId,
          name: controllerName.text.trim(),
          description: controllerDescription.text.trim(),
          price: double.parse(controllerPrice.text.trim()),
          imageUrl: imageUrl,
          isAvailable: true,
          categories: selectedCategory);

      // Add the product to 'products' collection in Firestore
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .set(newProduct.toMap());

      // Show success message or navigate to another screen
      print("Product added successfully!");
    } catch (e) {
      print("Error adding product: $e");
    }
  }

  Future<void> uploadImageToFirebase(
      File image, String firebaseStoragePath) async {
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

//koment
  @override
  Widget build(BuildContext context) {
    final List<String> categories = ['None', 'All', 'Category A', 'Category B'];
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
              padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                      child: Expanded(
                        child: image == null
                            ? Center(
                                child: TextButton(
                                  onPressed: pickImage,
                                  child: const Text(
                                    'Select image',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
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
                  // File? image = await pickImage();
                  if (selectedCategory != 'None') {
                    addProductToFirestore();
                    Navigator.pop(context);
                  } else {
                    showSnackbar(context, 'Please select a category');
                  }
                  // uploadImageToFirebase(image!,
                  //     "images/${DateTime.now().millisecondsSinceEpoch}.jpg");
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blueAccent),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        'Save',
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
            // FloatingActionButton(
            //   onPressed: () async {
            //     // File? image = await pickImage();
            //     addProductToFirestore();
            //     uploadImageToFirebase(image!,
            //         "images/${DateTime.now().millisecondsSinceEpoch}.jpg");
            //   },
            //   child: Text("save"),
            // )
          ],
        ),
      ),
    );
  }
}
