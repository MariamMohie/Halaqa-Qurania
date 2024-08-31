import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UserNetwork {
  
  
  
  // api for get the cities of any country

 static Future<List> getcities(String country) async {
    final response = await http.get(Uri.parse(
        'https://countriesnow.space/api/v0.1/countries/cities/q?country=$country'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      List cities = data['data'];
      
     return cities;
    } else {
      throw Exception('Failed to load cities');
    }
  }

  // send user data to firebase

  static Future<void> sendUserData(String name, String country, String city , String phonenumber, String age,String gender) async {
    
    FirebaseFirestore.instance.collection('UserInfo').doc(FirebaseAuth.instance.currentUser!.uid).set({
    'name' : name,
    'country' : country,
    'city' : city,
    'phonenumber' : phonenumber,
    'age' :age,
    'gender' : gender,
    'email':FirebaseAuth.instance.currentUser!.email,
    'uid':FirebaseAuth.instance.currentUser!.uid,
    'lastseen':DateFormat.Hm("en_US").format(DateTime.now())

    });

  }




}