import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/models/doctor.dart';

import '../models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');

  Future updateUserData(
      String name,
      String gender,
      String email,
      String address,
      int phone_number,
      DateTime date_of_birth,
      String avatar) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'gender': gender,
      'email': email,
      'address': address,
      'phone_number': phone_number,
      'date_of_birth': date_of_birth,
      'avatar': avatar
    });
  }

  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapShot);
  }

  Future nestedCollections() async {
    final CollectionReference nestedCollection =
        FirebaseFirestore.instance.collection('User');
    nestedCollection
        .doc(uid)
        .collection('Medical_examination_history')
        .add({'time': DateTime.now()});
  }

  //userData from snapshot
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot['name'],
        gender: snapshot['gender'],
        email: snapshot['email'],
        address: snapshot['address'],
        phone_number: snapshot['phone_number'],
        date_of_birth: snapshot['date_of_birth'].toDate(),
        user_avatar: snapshot['avatar']);
  }
}

//-------------------------DOCTOR------------------------

class DatabaseServiceDoctor {
  final String uid;
  DatabaseServiceDoctor({required this.uid});

  final CollectionReference doctorCollection =
      FirebaseFirestore.instance.collection('Doctors');

  Future updateDoctorData(
      String name,
      String gender,
      String email,
      String address,
      int phoneNumber,
      DateTime dateOfBirth,
      List doctorExp,
      String expNum,
      String specialty,
      String avatar) async {
    return await doctorCollection.doc(uid).set({
      'name': name,
      'gender': gender,
      'email': email,
      'address': address,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth,
      'experiences': doctorExp,
      'years_of_experience': expNum,
      'specialty': specialty,
      'avatar': avatar,
    });
  }

  Stream<DoctorData> get doctorData {
    return doctorCollection.doc(uid).snapshots().map(_doctorDataFromSnapShot);
  }

  Future nestedCollections() async {
    final CollectionReference nestedCollection =
        FirebaseFirestore.instance.collection('Doctors');
    nestedCollection.doc(uid).collection('Medical_examination_history').add({});
  }

  Future addDocsNestedCollections(
      String uidDoctor,
      String uidUser,
      DateTime bookingDate,
      String bookingTime,
      String userName,
      int userPhoneNum,
      String userAddress,
      String userAvatar) async {
    doctorCollection
        .doc(uidDoctor)
        .collection('Medical_examination_history')
        .doc(uidUser)
        .set({
      'date': DateTime.now(),
      'booking_date': bookingDate,
      'booking_time': bookingTime,
      'user_name': userName,
      'user_phone_num': userPhoneNum,
      'user_address': userAddress,
      'user_avatar': userAvatar
    });
  }

  Future updateArrayExp(String exp) async {
    return await doctorCollection.doc(uid).update({
      'experiences': FieldValue.arrayUnion([exp])
    });
  }

  Future removeArrayExp(String exp) async {
    return await doctorCollection.doc(uid).update({
      'experiences': FieldValue.arrayRemove([exp])
    });
  }

  DoctorData _doctorDataFromSnapShot(DocumentSnapshot snapshot) {
    return DoctorData(
        name: snapshot['name'],
        gender: snapshot['gender'],
        email: snapshot['email'],
        address: snapshot['address'],
        phoneNumber: snapshot['phone_number'],
        dateOfBirth: snapshot['date_of_birth'].toDate(),
        doctorExp: snapshot['experiences'],
        expNum: snapshot['years_of_experience'],
        specialty: snapshot['specialty'],
        doctorAvatar: snapshot['avatar']);
  }
}
