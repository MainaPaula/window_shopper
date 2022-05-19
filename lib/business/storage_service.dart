import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebaseCore;
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

class Storage {
  final firebaseStorage.FirebaseStorage storage = firebaseStorage.FirebaseStorage.instance;

  //Function to upload the image
  Future<void> uploadFile (String filePath, String fileName) async{
    File file = File(filePath);

    try{
      await storage.ref('Businesses/$fileName').putFile(file);
    } on firebaseCore.FirebaseException catch (error) {
      print(error);
    }
  }

  //Function to retrieve the image
  Future<String> downloadURL(String imageName) async {
    String downloadUrl = await storage.ref('Businesses/$imageName').getDownloadURL();

    return downloadUrl;
  }
}