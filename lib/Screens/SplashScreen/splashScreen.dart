import 'dart:async';
import 'package:esos/CustomWidgets/loadingWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/strings.dart';
import '../../CustomWidgets/screen_background.dart';
import '../../Models/global_state.dart';
import 'cubit/splashScreenCubit.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalState _globalState = GlobalState();
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    print(user);
    if (user==null) {
      Future.delayed(Duration(milliseconds: 2000)).then(
              (value) => Navigator.pushReplacementNamed(context, S.routeWelcome));
    } else {
      context.read<SplashScreenCubit>().getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          const ScreenBackground(),
          BlocConsumer<SplashScreenCubit, SplashScreenState>(
            listener: (context, state) {
              if (state is SplashScreenError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                    Text("Something went wrong. Try loging in again.")));
                Navigator.pushReplacementNamed(context, S.routeWelcome);
              } else if (state is SplashScreenSuccess) {
                Future.delayed(const Duration(milliseconds:2000)).then(
                        (value) =>(FirebaseAuth.instance.currentUser!.displayName==null)?Navigator.pushReplacementNamed(context, S.routeProfile):Navigator.pushReplacementNamed(context, S.routeHome));
              }
            },
            builder: (context, state) {
              if (state is SplashScreenSuccess || state is SplashScreenLoading) {
              return LoadingScreen();
              } else {
                return Center(
                  child: Text("Check your internet connection and try again"),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
