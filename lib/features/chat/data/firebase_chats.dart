import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:islamic/features/chat/data/models/user_model.dart';
import 'package:uuid/uuid.dart';

class firebase_chats {
  // get all users from firebase

  static Stream<QuerySnapshot> getallusers() {
    return FirebaseFirestore.instance
        .collection('UserInfo')
        .where('email', isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots();
  }

  // create new chat
  static Future<void> createchat(
      String otheruserid, String otherusername, String otheruserimage) async {
    user_model userobj = await getUserinfo();

    var uuid = Uuid();
    String chatid = uuid.v4();
    await FirebaseFirestore.instance.collection('Chats').doc(chatid).set({
      'chatid': chatid,
      'userid': FirebaseAuth.instance.currentUser!.uid,
      'username': userobj.username,
      'userimage': userobj.userimage,
      'otheruserid': otheruserid,
      'otherusername': otherusername,
      'otheruserimage': otheruserimage,
      'lastmassage': "Created At",
      'timestamp': DateTime.now().microsecondsSinceEpoch,
      'part': [FirebaseAuth.instance.currentUser!.uid, otheruserid],
      'lastmassagetime': DateFormat.Hm("en_US").format(DateTime.now())
    });
  }

  // get userInfo
  static Future<user_model> getUserinfo() async {
    Map<String, dynamic> userinfo = {};
    await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userinfo['userid'] = value['uid'];
      userinfo['username'] = value['name'];
      userinfo['userimage'] = value['userimage'];
    });
    return user_model.fromJson(userinfo);
  }

  // get user chats
  static Stream<QuerySnapshot> getuserchats() {
    return FirebaseFirestore.instance
        .collection('Chats')
        .where('part', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  // get currentuser id
  static String getcurrentuserid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  // check if the chat is already exist
  static Future<bool> checkchat(String otheruserid) async {
    bool exist = false;
    await FirebaseFirestore.instance
        .collection('Chats')
        .where('part', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['part'].contains(otheruserid)) {
          exist = true;
        }
      });
    });
    return exist;
  }

  // send massage
  static Future<void> sendmassage(
      String chatid, String massage, String type) async {
    await FirebaseFirestore.instance.collection('Chats').doc(chatid).update({
      'lastmassage': type == "text"
          ? massage
          : type == "image"
              ? "Media"
              : 'voice massage',
      'timestamp': DateTime.now().microsecondsSinceEpoch,
      'lastmassagetime': DateFormat.Hm("en_US").format(DateTime.now())
    });
    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatid)
        .collection('Massages')
        .add({
      'senderid': FirebaseAuth.instance.currentUser!.uid,
      'sendername': (await getUserinfo()).username,
      'senderimage': (await getUserinfo()).userimage,
      'massage': massage,
      'type': type,
      //! time order
      'timestamp': DateTime.now().microsecondsSinceEpoch,
      //! actual time for message in chat
      //? hm ---> hour min
      'time': DateFormat.Hm("en_US").format(DateTime.now()),
      'seen': false
    });
  }

  // take image
  static void takeanduploadimage(String chatid, bool take) async {
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
      sendmassage(chatid, await ref.getDownloadURL(), "image");
    }
  }

  // upload video
  static void uploadvideo(String chatid) async {
    File? file;
    ImagePicker picker = ImagePicker();
    XFile? video = await picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      file = File(video.path);
      var metadata = SettableMetadata(
        contentType: "video/mp4",
      );
      var videoname = basename(video.path);
      var ref = FirebaseStorage.instance.ref(videoname);
      await ref.putFile(file, metadata);
      sendmassage(chatid, await ref.getDownloadURL(), "video");
    }
  }

// get massages
  static Stream<QuerySnapshot> getmassages(String chatid) {
    return FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatid)
        .collection('Massages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

// upload audio
  static Future<void> uploadAudio(
      String chatid, String path, String type) async {
        //! add a sub collection named records
    var ref = await FirebaseStorage.instance
        .ref()
        .child("records")
        .child("${Uuid().v4()}.m4a");

    var metadata = SettableMetadata(
      contentType: "audio/x-m4a",
    );
    await ref.putFile(File(path), metadata);

    sendmassage(chatid, await ref.getDownloadURL(), type);
  }

  // update lasetseen
  static Future<void> updateLastseen() async {
    await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'lastseen': DateFormat.Hm("en_US").format(DateTime.now())});
  }

  // get last seen
  static Future<String> getLastseen(String userid) async {
    String lastseen = "";
    await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(userid)
        .get()
        .then((value) {
      lastseen = value['lastseen'];
    });
    return lastseen;
  }

  // mark seen
  static Future<void> markSeen(String chatid, String senderid) async {
    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatid)
        .collection('Massages')
        .where('senderid', isEqualTo: senderid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.update({'seen': true});
      });
    });
  }

//   // search chat by username
  static Future<String> searchbyname(String username) async {
    String chatid = "";
    await FirebaseFirestore.instance
        .collection('Chats')
        .where('part', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['username'].toString().toUpperCase() ==
            username.toUpperCase()) {
          chatid = element.data()['chatid'];
        } else if (element.data()['otherusername'].toString().toUpperCase() ==
            username.toUpperCase()) {
          chatid = element.data()['chatid'];
        } else {
          chatid = "";
        }
      });
    });

    return chatid;
  }

  // get chat by chatid this is used in the search bar to make the chats I searched about appear
  static Stream<QuerySnapshot> getchatbychatid(String chatid) {
    return FirebaseFirestore.instance
        .collection('Chats')
        .where('chatid', isEqualTo: chatid)
        .snapshots();
  }

  //! get userInfo by userid in profile screen
  static Future<Map<String, dynamic>> getUserinfoById(String userid) async {
    Map<String, dynamic> userinfo = {};
    await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(userid)
        .get()
        .then((value) {
      userinfo['userid'] = value['uid'];
      userinfo['username'] = value['name'];
      userinfo['userimage'] = value['userimage'];
      userinfo['age'] = value['age'];
      userinfo['city'] = value['city'];
      userinfo['country'] = value['country'];
      userinfo['email'] = value['email'];
      userinfo['country'] = value['country'];
      userinfo['lastseen'] = value['lastseen'];
      userinfo['phonenumber'] = value['phonenumber'];
    });
    return userinfo;
  }

  // delete chat by chatid from profile screen
  static Future<void> deletechat(String chatid) async {
    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatid)
        .collection('Massages')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
      });
    });
    await FirebaseFirestore.instance.collection('Chats').doc(chatid).delete();
  }

  // delete massage by chatid and massageid
  static Future<void> deletemassage(String chatid, String massageid) async {
    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatid)
        .collection('Massages')
        .doc(massageid)
        .delete();
  }
}
