import 'dart:convert';

import 'package:flutter/material.dart';

class UserModel{
  late String id;
  late String email;
  late String fristName;
  late String lastName;
  late String mobile;
  String ? photo;

  String get fullName {
    return '$fristName $lastName';
  }

  UserModel(
  {
    required this.id,
    required this.email,
    required this.fristName,
    required this.lastName,
    required this.mobile,
    this.photo,
}
    );

  UserModel.fromJson(Map<String,dynamic> jsonData ){
    id = jsonData['id'];
    fristName = jsonData['frisName'];
    lastName = jsonData['lastName'];
    mobile = jsonData['mobile'];
    photo = jsonData['photo'];
  }

  Map<String,dynamic> toJson()
  {
    return{
      'id' : id,
      'fristName' : fristName,
      'lastName' : lastName,
      'mobile' : mobile,
      'photo' : photo,
    };
  }
}