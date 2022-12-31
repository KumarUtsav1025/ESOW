import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esos/Models/errors.dart';
import 'package:esos/Models/users.dart';
import 'package:flutter/cupertino.dart';
import '../../../Constants/strings.dart';
import '../network.dart';


part 'homeState.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeNetwork _homeNetwork;
  HomeCubit(this._homeNetwork) : super(const HomeLoading());

  Future<void> sendSMS(
      String msg, List<String> listReceipents) async {
    try {
      emit(HomeLoading());
      String? message = await _homeNetwork.sendingSMS(msg: msg, listReceipents: listReceipents);
      emit(SMSSuccess(message!));
    } on CustomException catch(e) {
      print(3);
      emit(HomeError(e.description));
    } catch (e) {
      print(4);
      emit(HomeError(e.toString()));
    }
  }

  Future<void> getUser() async {
    try {
      emit(ProfileLoading());
      UserProfile? userProfile = await _homeNetwork.getUserDetails();
      emit(HomeSuccess(userProfile!));
    } on CustomException catch(e) {
      print(1);
      emit(HomeError(e.description));
    } catch (e) {
      print(2);
      emit(HomeError(e.toString()));
    }
  }
}
