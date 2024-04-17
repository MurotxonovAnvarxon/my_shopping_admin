import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Item {
  String id;
  String name;
  String description;
  int price;
  bool inStock;
  String imageUrl;

  Item(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.inStock,
      required this.imageUrl});

  String get formattedAvailability => inStock ? "Available" : "Out of stock";

  String get formattedPrice => Item.formatter.format(this.price);

  Color get availabilityColor => inStock ? Colors.grey : Colors.red;

  static final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: "So'm ");
  
  // static List<Item>  dummyItems=getImageInformationList("storagePath");
  // >[

    // Item(id: get, name: name, description: description, price: price, inStock: inStock, imageUrl: imageUrl)
  // ];

  static List<Item> get dummyItems => [
        Item(
            id: "1",
            name: "Stullar",
            description: '20 talik toplam',
            price: 200000,
            inStock: true,
            imageUrl:
                'https://frankfurt.apollo.olxcdn.com/v1/files/yaphoxo79ba73-UZ/image;s=1264x547'),
        Item(
            id: "2",
            name: "Stullar",
            description: '8 talik toplam',
            price: 1500000,
            inStock: true,
            imageUrl:
                'https://tashmebel.uz/wp-content/uploads/2022/11/photo_2022-05-28_01-32-51.jpg'),
        Item(
            id: "3",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 20000,
            inStock: true,
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIOhbGLCziCi6-P40I7RHB31-JoIuZo-3-Mmda2LrGrw&s'),
        Item(
            id: "4",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 200000,
            inStock: true,
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVYko2a7vQoaOFL4Cx-b8a-sPkW7w18kYrkrPbipiNJg&s'),
        Item(
            id: "5",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 20000,
            inStock: true,
            imageUrl:
                'https://m.media-amazon.com/images/I/81IRT5qqW0L._AC_UF1000,1000_QL80_.jpg'),
        Item(
            id: "6",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 20000,
            inStock: true,
            imageUrl:
                'https://img.staticmb.com/mbcontent/images/uploads/2022/5/wedding%20stage%20decoration.jpg'),
        Item(
            id: "7",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1uYhoR8ozyv4nHN2zClzuIhI8NeXSQF03D4BwlRSzpw&s'),
        Item(
            id: "8",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://img.staticmb.com/mbcontent/images/uploads/2022/5/wedding%20stage%20decoration.jpg'),
        Item(
            id: "9",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://rukminim2.flixcart.com/image/850/1000/xif0q/decoration/w/n/o/2000-large-0-75-8970429098-balloon-decoration-arch-stand-samanth-original-imagjwbtzwhyxfha.jpeg?q=90&crop=true'),
        Item(
            id: "10",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "11",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "12",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "13",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "14",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "15",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "16",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "17",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "18",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "19",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "20",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "21",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "22",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "23",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "24",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "25",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
        Item(
            id: "26",
            name: "Decaration",
            description: 'More magical than ever.',
            price: 2000,
            inStock: true,
            imageUrl:
                'https://d2j6dbq0eux0bg.cloudfront.net/images/7533597/3712335336.jpg'),
      ];
}

Future<List<Map<String, dynamic>>?> getImageInformationList(String storagePath) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('productLast')
        .where('storagePath', isEqualTo: storagePath)
        .get();

    List<Map<String, dynamic>> imageInfoList = [];

    if (querySnapshot.docs.isNotEmpty) {
      // Iterate over the documents in the query snapshot
      querySnapshot.docs.forEach((document) {
        // Extract metadata from each document and add to the list
        Map<String, dynamic> imageInfo = document.data() as Map<String, dynamic>;
        imageInfoList.add(imageInfo);
      });

      return imageInfoList;
    } else {
      print('No image information found for storagePath: $storagePath');
      return null;
    }
  } catch (e) {
    print('Error retrieving image information: $e');
    return null;
  }
}

