import 'package:esos/Screens/Home/network.dart';
import 'package:esos/Screens/Login/loginNetwork.dart';
import 'package:esos/Screens/ProfileForm/profileNetwork.dart';
import 'package:esos/Screens/SignUp/signUpNetwork.dart';
import 'package:esos/Screens/SplashScreen/cubit/splashScreenCubit.dart';
import 'package:esos/Screens/SplashScreen/splashScreenNetwork.dart';
import 'package:esos/Screens/Welcome/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'Screens/Home/cubit/homeCubit.dart';
import 'Screens/Home/home.dart';
import 'Screens/ProfileForm/cubit/profileCubit.dart';
import 'Screens/ProfileForm/profileForm.dart';
import 'Screens/SplashScreen/splashScreen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Constants/colors.dart';
import 'Models/global_state.dart';
import 'Screens/Login/cubit/loginCubit.dart';
import 'Screens/SignUp/cubit/signUpCubit.dart';
import 'Screens/SignUp/signup.dart';
import 'Screens/Login/login.dart';
import 'package:provider/provider.dart';
import 'constants/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Provider(
      create: (_)=> GlobalState(),
      child: MaterialApp(
        title: 'ESOW',
        routes: {
          S.routeHome: (_) => BlocProvider(
              create: (_) => HomeCubit(HomeNetwork()),
              child: Home()),
          S.routeProfile: (_) => BlocProvider(
              create: (_) => ProfileCubit(FirebaseProfile()),
              child: Profile()),
          S.routeSplash: (_) => BlocProvider(
              create: (_) => SplashScreenCubit(SplashNetwork()),
              child: SplashScreen()),
          S.routeWelcome: (_) => const Welcome(),
          S.routeLogin: (_) => BlocProvider(
              create: (_) => LoginCubit(FirebaseLogin()),
              child: Login()),
          S.routeSignup: (_) => BlocProvider(
              create: (_) => SignupCubit(FirebaseSignup()),
              child: SignUp()),
        },
        initialRoute: S.routeSplash,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: C.gradientColor3,
          secondary: C.gradientColor,
          )
        ),
        home: const Welcome(),
      ),
    );
  }
}
