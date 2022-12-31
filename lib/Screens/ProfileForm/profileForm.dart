import 'dart:io';
import 'dart:ui';
import 'package:esos/CustomWidgets/loadingWidget.dart';
import 'package:esos/CustomWidgets/screen_background.dart';
import 'package:esos/CustomWidgets/textfield.dart';
import 'package:esos/Models/global_state.dart';
import 'package:esos/Models/location_history.dart';
import 'package:esos/Screens/ProfileForm/locationPermission.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../CustomWidgets/button.dart';
import '../../CustomWidgets/frostedGlass.dart';
import '../../Models/users.dart';
import '../../constants/colors.dart';
import '../../constants/dimens.dart';
import '../../constants/strings.dart';
import 'cubit/profileCubit.dart';

class Profile extends StatefulWidget {


  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  LocationTrack locationTrack = LocationTrack();
  final GlobalState _globalState = GlobalState();
  final _formKey = GlobalKey<FormState>();
  Map<String, List<String>>? locationData;
  final TextEditingController contactController = TextEditingController();
  final TextEditingController contact2Controller = TextEditingController();
  final TextEditingController contact3Controller = TextEditingController();
  final TextEditingController contact4Controller = TextEditingController();
  final TextEditingController contact5Controller = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  PermissionStatus _permissionStatusSMS = PermissionStatus.denied;
  PermissionStatus _permissionStatusLocation = PermissionStatus.denied;
  final Permission _permissionSMS = Permission.sms;
  final Permission _permissionLocation = Permission.locationAlways;

  User? user;
  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
    user =FirebaseAuth.instance.currentUser;
  }

  void _listenForPermissionStatus() async {
    final status1 = await _permissionSMS.status;
    final status2 = await _permissionLocation.status;
    setState(() {
      _permissionStatusLocation = status2;
      _permissionStatusSMS = status1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(
                state.message, style: TextStyle(color: C.gradientColor3),),
                backgroundColor: C.fieldColor,));
            }
            else if (state is ProfileSuccess) {
              context.read<GlobalState>().userProfile = state.userProfile;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(
                "Profile Created Successfully",
                style: TextStyle(color: C.gradientColor3),),
                backgroundColor: C.fieldColor,));
              Navigator.pushReplacementNamed(context, S.routeSplash);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                const ScreenBackground(),
                if (state is ProfileLoading)
                  _buildLoading(context)
                else
                  _buildSuccess(context, width, height),
              ],
            );
          }
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return LoadingScreen();
  }

  Widget _buildSuccess(BuildContext context, width, height) {
    return SafeArea(
      child: Container(
        width: width,
        height: height,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Complete Profile",
                style: GoogleFonts.cabin(
                    color: C.gradientColor3,
                    fontSize: 28, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 15.0,),
              CustomField(controller: _textController,
                  label: 'Set Name',
                  icon: Icons.person_outline_outlined,
                  obsText: false),
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    PhoneField(controller: contactController,
                        label: 'Contact Number 1',
                        icon: Icons.contact_page,
                        obsText: false),
                    PhoneField(controller: contact2Controller,
                        label: 'Contact Number 2',
                        icon: Icons.contact_page,
                        obsText: false),
                    PhoneField(controller: contact3Controller,
                        label: 'Contact Number 3',
                        icon: Icons.contact_page,
                        obsText: false),
                    PhoneField(controller: contact4Controller,
                        label: 'Contact Number 4',
                        icon: Icons.contact_page,
                        obsText: false),
                    PhoneField(controller: contact5Controller,
                        label: 'Contact Number 5',
                        icon: Icons.contact_page,
                        obsText: false),
                  ],
                ),
              ),
              SizedBox(height: 15.0,),
              ProfileButton(
                title: 'Grant Location',
                fillColor: C.backgroundColor,
                borderColor: C.gradientColor3,
                primaryIcon: Icons.location_on_outlined,
                secondaryIcon: Icons.pending_rounded,
                onClick: () async{
                  requestPermission(Permission.locationAlways);
                  setState(() {
                    _listenForPermissionStatus();
                  });
                },
              ),
              ProfileButton(
                title: 'Grant SMS',
                fillColor: C.backgroundColor,
                borderColor: C.gradientColor3,
                primaryIcon: Icons.message,
                secondaryIcon: Icons.pending_rounded,
                onClick: () {
                  requestPermission(Permission.sms);
                  setState(() {
                    _listenForPermissionStatus();
                  });
                },
              ),
              FormButton(title: 'Proceed',
                  fillColor: C.backgroundColor,
                  borderColor: C.gradientColor3,
                  onClick: () {
                    _profile(context);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _profile(BuildContext context) async{
    final cubit = context.read<ProfileCubit>();
    print(user!.uid.toString());
    print(user!.email.toString());
    print(_textController.text);
    print(locationData);
    if (_formKey.currentState!.validate()) {
      cubit.profileUpload(UserProfile(userId: user!.uid.toString(),
          name: _textController.text,
          contactNumber: [contactController.text,
            contact2Controller.text,
            contact3Controller.text,
            contact4Controller.text,
            contact5Controller.text,
          ],
          email: user!.email.toString())
      );
    }
    else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(
        "Fill Form Cautiously", style: TextStyle(color: C.gradientColor3),),
        backgroundColor: C.fieldColor,));
    }
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
    if (status != PermissionStatus.granted) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Permission Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Please allow required permission!'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  exit(0);
                },
                child: const Text('Close App'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                child: const Text('Open app settings'),
              ),
            ],
          );
        },
      );
    }

    else if (status == PermissionStatus.granted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(
        "Permission Granted Successfully",
        style: TextStyle(color: C.gradientColor3),),
        backgroundColor: C.fieldColor,));
    }
  }

}
