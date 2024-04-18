import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  File? image;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();

  String imageUrl = ''; // Set the actual image URL here

  // Function to generate a unique ID (e.g., using Firestore auto-generated ID)
  String generateUniqueId() {
    return FirebaseFirestore.instance
        .collection('productsLast')
        .doc()
        .id;
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // Adjust as needed
      ),
    );
  }

  // Future<void> uploadImageToFirebase(
  //     File image, String firebaseStoragePath) async {
  //   try {
  //     // Firebase Storage ni olish
  //     final storage = FirebaseStorage.instance;
  //
  //     // Rasmni yuklash uchun StorageReference obyektini olish
  //     final ref = storage.ref().child(firebaseStoragePath);
  //
  //     // Rasmni yuklash
  //     await ref.putFile(image);
  //
  //     // Yuklab olingan rasm URL sini olish
  //     String downloadURL = await ref.getDownloadURL();
  //     print("Rasm muvaffaqiyatli yuklandi. URL: $downloadURL");
  //   } catch (e) {
  //     print("Rasmni yuklashda xatolik yuz berdi: $e");
  //   }
  // }
//

  Future uploadImage(String path) async {
    try {
      if (image != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('images/${path}.png');
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

  Future<void> uploadImageToStorageAndFirestore(String id,
      String imagePath,
      String productName,
      String productDescription,
      String productPrice,
      String productCategories,
      File? image,) async {
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

//   Future<List<String>> getImageUrlsFromFirestore(String storagePath) async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('productLast')
//           .where('storagePath', isEqualTo: storagePath)
//           .get();
//
//       List<String> imageUrlList = [];
//
//       if (querySnapshot.docs.isNotEmpty) {
//         querySnapshot.docs.forEach((DocumentSnapshot document) {
//           String imageUrl = document.get('imageUrl');
//           imageUrlList.add(imageUrl);
//         });
//
//         return imageUrlList;
//       } else {
//         print('No image URLs found for storagePath: $storagePath');
//         return [];
//       }
//     } catch (e) {
//       print('Error retrieving image URLs: $e');
//       return [];
//     }
//   }
//
// // Method to retrieve a list of image paths from Firebase Storage
//   Future<List<String>> getImagePathsFromStorage(String storagePath) async {
//     try {
//       List<String> imagePaths = [];
//
//       // Create a reference to the desired path in Firebase Storage
//       Reference storageRef = FirebaseStorage.instance.ref().child(storagePath);
//
//       // List all items (files and directories) within the specified path
//       ListResult listResult = await storageRef.listAll();
//
//       // Iterate through each item (file) in the list result
//       listResult.items.forEach((Reference item) {
//         // Get the full path (including parent path) of the item
//         String fullPath = item.fullPath;
//         // Add the full path to the list of image paths
//         imagePaths.add(fullPath);
//       });
//
//       return imagePaths;
//     } catch (e) {
//       print('Error retrieving image paths from Firebase Storage: $e');
//       return []; // Return an empty list in case of error
//     }
//   }
//
//   void fetchAndPrintImagePaths(String storagePath) async {
//     try {
//       List<String> imagePaths = await getImagePathsFromStorage(storagePath);
//
//       if (imagePaths.isNotEmpty) {
//         // Print each image path in the list
//         print('Image Paths:');
//         imagePaths.forEach((path) {
//           print(path);
//         });
//       } else {
//         print('No image paths found.');
//       }
//     } catch (e) {
//       print('Error fetching and printing image paths: $e');
//     }
//   }
//
//   void fetchImagePaths(String storagePath) async {
//     List<String> imagePaths = await getImagePathsFromStorage(storagePath);
//
//     if (imagePaths.isNotEmpty) {
//       // Image paths retrieved successfully
//       print('Image paths found:');
//       imagePaths.forEach((path) {
//         print(path);
//       });
//
//       // Now you can use the retrieved image paths to download or display images
//     } else {
//       // No image paths found or error occurred
//       print('No image paths found in Firebase Storage for path: $storagePath');
//     }
//   }
//
//   Future<String?> uploadImageToFirebase(XFile? image) async {
//     if (image == null) return null;
//     File file = File(image.path);
//     try {
//       String fileName =
//           'images/${DateTime.now().millisecondsSinceEpoch}_${image.name}';
//       await FirebaseStorage.instance.ref(fileName).putFile(file);
//       String downloadURL =
//       await FirebaseStorage.instance.ref(fileName).getDownloadURL();
//       return downloadURL;
//     } on FirebaseException catch (e) {
//       print(e);
//       return null;
//     }
//   }

  // void initState() {
  //   fetchAndPrintImagePaths('rasm/');
  //   print('----------------------------------------------------');
  //   print("---------+   ${getImagePathsFromStorage('rasm/').toString()}");
  //   super.initState();
  // }

  //
  // // Function to add product to Firestore
  // Future<void> addProductToFirestore() async {
  //   try {
  //     String productId = generateUniqueId();
  //
  //     // Create a Product instance with the entered data
  //     Product newProduct = Product(
  //         id: productId,
  //         name: controllerName.text.trim(),
  //         description: controllerDescription.text.trim(),
  //         price: double.parse(controllerPrice.text.trim()),
  //         imageUrl: imageUrl,
  //         isAvailable: true,
  //         categories: selectedCategory);
  //
  //     // Add the product to 'products' collection in Firestore
  //     await FirebaseFirestore.instance
  //         .collection('products')
  //         .doc(productId)
  //         .set(newProduct.toMap());
  //
  //     // Show success message or navigate to another screen
  //     print("Product added successfully!");
  //   } catch (e) {
  //     print("Error adding product: $e");
  //   }
  // }
  //
  // Future<void> uploadImageToFirebase(
  //     File image, String firebaseStoragePath) async {
  //   try {
  //     // Firebase Storage ni olish
  //     final storage = FirebaseStorage.instance;
  //
  //     // Rasmni yuklash uchun StorageReference obyektini olish
  //     final ref = storage.ref().child(firebaseStoragePath);
  //
  //     // Rasmni yuklash
  //     await ref.putFile(image);
  //
  //     // Yuklab olingan rasm URL sini olish
  //     String downloadURL = await ref.getDownloadURL();
  //     print("Rasm muvaffaqiyatli yuklandi. URL: $downloadURL");
  //   } catch (e) {
  //     print("Rasmni yuklashda xatolik yuz berdi: $e");
  //   }
  // }


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
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: InkWell(
                onTap: () {
                  pickImage();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 1)),
                  height: MediaQuery
                      .of(context)
                      .size
                      .width / 2,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: image == null
                              ? const Center(
                            child: Text(
                              'Select image',
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
                  if (selectedCategory == 'None') {
                    showSnackbar(context, 'Please select a category');
                  } else if (controllerName.text.length < 4) {
                    showSnackbar(
                        context, 'The name must be longer than 4 characters');
                  } else if (controllerDescription.text.length < 4) {
                    showSnackbar(context,
                        'The description must be longer than 4 characters');
                  } else if (controllerPrice.text.isEmpty) {
                    showSnackbar(context, 'Please enter a valid price');
                  } else {
                    var idAndPath = generateUniqueId();
                    uploadImage(idAndPath);
                    uploadImageToStorageAndFirestore(
                        idAndPath,
                        idAndPath,
                        controllerName.text,
                        controllerDescription.text,
                        controllerPrice.text,
                        selectedCategory,
                        image);
                    Navigator.pop(context);
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
          ],
        ),
      ),
    );
  }
}
