import 'package:esos/Models/errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Constants/strings.dart';


class SplashNetwork {

  Future<User> getProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if(user!=null) {
      return user;
    } else {
      throw CustomException("Error");
    }
  }
}

