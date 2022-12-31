import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esos/Models/errors.dart';
import 'package:esos/Models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Models/global_state.dart';


class FirebaseProfile {

  Future<void> profileUpload({required UserProfile userProfile}) async {
    final CollectionReference userRef = FirebaseFirestore.instance.collection('Users');
    User user=FirebaseAuth.instance.currentUser!;
    Map<String, dynamic> userData = userProfile.toJson();
    try{
      await userRef.doc(userProfile.userId).set(userData)
          .then((_){
        print('Added');
      });
      print("${userProfile.name}4566");
      await user.updateDisplayName(userProfile.name);
    }
    catch (e){
      throw CustomException('Simething Went Wrong');
    }
  }
}
