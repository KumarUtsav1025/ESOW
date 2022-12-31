import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:esos/Models/location_history.dart';

class UserProfile extends Equatable {

  String email;
  String userId;
  String name;
  List<String> contactNumber;
  List<String> locationTimestamp;

  UserProfile({
    required this.userId,
    required this.name,
    required this.contactNumber,
    required this.email,
    required this.locationTimestamp,
  });

  UserProfile.fromJson(Map<String, dynamic> json):
        userId=json['userid'],
        name = json['name'],
        email = json['email'],
        contactNumber=json['contactNumber'],
        locationTimestamp=json['locationTimestamp']
  ;

  factory UserProfile.fromFirestore(Map<String, dynamic> data) {
    return UserProfile(
      name: data['name'],
      userId: data['userId'],
      contactNumber: List<String>.from(data['contactNumber']),
      email: data['email'],
      locationTimestamp: List<String>.from(data['locationTimestamp']),
    );
  }

  Map<String, dynamic> toJson() => {
    'userId':userId,
    'name': name,
    'email': email,
    'contactNumber':contactNumber,
    'locationTimestamp':locationTimestamp,
  };

  @override
  List<Object?> get props => [email];
}