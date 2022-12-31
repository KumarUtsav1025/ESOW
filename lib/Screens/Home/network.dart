import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esos/Models/errors.dart';
import 'package:esos/Models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sms/flutter_sms.dart';

class HomeNetwork{
  //Sms sending
  Future<String> sendingSMS({ required String msg, required List<String> listReceipents}) async {
    String sendResult = await sendSMS(message: msg, recipients: listReceipents, sendDirect: true)
        .catchError((err) {
          print(err);
          throw CustomException(err.toString());
        });
    return sendResult;
  }

  Future<UserProfile> getUserDetails() async{
    final docRef = FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid);
    return await docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        print(data);
        return UserProfile.fromFirestore(data);
      },
      onError: (e){
            print("Error getting document: $e");
            throw CustomException(e.toString());
      },
    );
  }

  Future<void> updateData({required List<String> data}) async {
    final docRef = FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid);
    try{
      await docRef.update({'locationTimestamp':data})
          .then((_){
        print('Added');
      });
    }
    catch (e){
      throw CustomException('Something Went Wrong');
    }
  }

}