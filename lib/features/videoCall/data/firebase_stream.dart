import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class firebase_stream {
  
  // take image
  static Future<String> takeanduploadimage(bool take) async {
    File? file;
    ImagePicker picker = ImagePicker();
    XFile? image = take == true
        ? await picker.pickImage(source: ImageSource.camera)
        : await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      file = File(image.path);
      var metadata = SettableMetadata(
        contentType: "image/jpeg",
      );
      var imgname = basename(image.path);
      var ref = FirebaseStorage.instance.ref(imgname);
      await ref.putFile(file, metadata);
      return ref.getDownloadURL();
    }
    return "";
  }
  // create stream at firebase firestore
   static void createstream(
      String streamname, String streamimage, String streamid) async {
    String username = "";
    String userimage = "";
    String usercity = "";
    String usercountry = "";
    await FirebaseFirestore.instance.collection('UserInfo').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      username = value['name'];
      userimage = value['userimage'];
      usercity = value['city'];
      usercountry = value['country'];
    });

    await FirebaseFirestore.instance.collection('Streams').add({
      'streamname': streamname,
      'streamimage': "https://img.freepik.com/free-photo/representation-user-experience-interface-design-smartphone_23-2150165977.jpg?t=st=1725045649~exp=1725049249~hmac=11b9dfb244ad97e60913e16c69a3be37c05303e9d458ed758c547687bae933b5&w=826",
      'streamid': streamid,
      'username': username,
      'userimage': userimage,
      'userlocation': "$usercity - $usercountry",
      'viewers':0


      // 'timestamp': FieldValue.serverTimestamp(),
    });
  }

// get streams
  static Stream<QuerySnapshot> getstreams() {
    return FirebaseFirestore.instance.collection('Streams').snapshots();
  }
// get userName
   static Future<String> getusername()async {
    String username = "";
   await FirebaseFirestore.instance
        .collection("UserInfo")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      username = value["name"];
    });
    return username;
  }


}
