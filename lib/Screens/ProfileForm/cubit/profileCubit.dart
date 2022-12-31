import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esos/Models/errors.dart';
import 'package:esos/Models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../Constants/strings.dart';
import '../profileNetwork.dart';


part 'profileState.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseProfile _firebaseProfile;
  ProfileCubit(this._firebaseProfile) : super(ProfileInitial());
  Future<void> profileUpload(UserProfile userProfile) async {
    try {
      emit(ProfileLoading());
      _firebaseProfile.profileUpload(userProfile: userProfile);
      emit(ProfileSuccess(userProfile));
    } on CustomException catch(e) {
      emit(ProfileError(e.description));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
