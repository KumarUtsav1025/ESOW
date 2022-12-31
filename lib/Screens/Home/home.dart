import 'package:esos/CustomWidgets/button.dart';
import 'package:esos/CustomWidgets/screen_background.dart';
import 'package:esos/Models/location_history.dart';
import 'package:esos/Models/users.dart';
import 'package:esos/Screens/Home/cubit/homeCubit.dart';
import 'package:esos/Screens/Home/network.dart';
import 'package:esos/Screens/ProfileForm/locationPermission.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import '../../Constants/dimens.dart';
import '../../Constants/strings.dart';
import '../../CustomWidgets/loadingWidget.dart';
import '../../CustomWidgets/textfield.dart';
import '../../constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';


class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  UserProfile? userProfile;
  @override
  void initState() {
    _getProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeError) {
                print('oh no');
                ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message,style: TextStyle(color: C.gradientColor3),),backgroundColor: C.fieldColor,));
              }
              else if (state is SMSSuccess) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("SMS sent successfully!",style: TextStyle(color: C.gradientColor3),),backgroundColor: C.fieldColor,));
              }
              if(state is HomeSuccess) {
                print('fuck');
                  userProfile = state.userProfile;
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  const ScreenBackground(),
                  if (state is HomeLoading || state is ProfileLoading)
                    _buildLoading(context)
                  else
                    _buildSuccess(context, width, height),
                ],
              );
            }
        ),
    );
  }

  Widget _buildSuccess(BuildContext context, width, height){
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProfileButton(title: 'SOS', fillColor: C.backgroundColor, borderColor: C.gradientColor3, primaryIcon: Icons.security_sharp, secondaryIcon: Icons.security_sharp,
                onClick: (){
                  print(userProfile);
                  _sendSMS(context);
                }),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                print(FirebaseAuth.instance.currentUser);
                Navigator.pushReplacementNamed(context, S.routeSplash);
              },
              child: Text('Sign Out'),

            ),
          ],
        ),
      )
    );
  }

  Widget _buildLoading(BuildContext context) {
    return LoadingScreen();
  }

  Future<void> _sendSMS(BuildContext context) async {
    final cubit = context.read<HomeCubit>();
    String location = await LocationTrack().getLocation();
    List<String> data = userProfile!.locationTimestamp;
    data.insert(0, location);
    print(userProfile);
    cubit.sendSMS('Happy New Year\n${location}', userProfile!.contactNumber,data);
  }

  void _getProfile(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    cubit.getUser();
  }
}







