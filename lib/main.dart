import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/shop_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShopListWidget(),
    );
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