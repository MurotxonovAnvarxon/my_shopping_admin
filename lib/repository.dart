import 'package:firebase_storage/firebase_storage.dart';

class DecorationRepository {
  Future<String> getDownloadURL(String gsUrl) async {
    try {
      if (!gsUrl.startsWith('gs://')) return gsUrl;
      final ref = FirebaseStorage.instance.refFromURL(gsUrl);
      return await ref.getDownloadURL();
    } catch (e) {
      print("Error fetching download URL: $e");
      return 'https://m.media-amazon.com/images/W/MEDIAX_792452-T2/images/I/81YkqyaFVEL._AC_UF1000,1000_QL80_.jpg';
    }
  }
}
