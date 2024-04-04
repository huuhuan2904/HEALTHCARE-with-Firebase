import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project/models/user.dart';
import 'package:project/share/loading.dart';
import 'package:provider/provider.dart';
import '../services/database.dart';
import '../share/constants.dart';

class UserPersonalInf extends StatefulWidget {
  const UserPersonalInf({super.key});

  @override
  State<UserPersonalInf> createState() => _UserPersonalInfState();
}

class _UserPersonalInfState extends State<UserPersonalInf> {
  List<String> genders = [
    "Nam",
    "Nữ",
    "Khác",
  ];
  DateTime dateTime = DateTime.now();
  String? _currentName;
  String? _currentGender;
  int? _currentPhone;
  String? _currentEmail;
  String? _currentAddress;
  DateTime? _currentDate;
  File? _selectedImage;
  String? downloadURL;
  final _formKey = GlobalKey<FormState>();

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    } else
      print('No image selected');
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    if (user != null) {
      return StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData? userData = snapshot.data;
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(color: Colors.black),
                  elevation: 0,
                  title: const Text(
                    'Thông tin cá nhân',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: InkWell(
                            onTap: () {
                              pickImageFromGallery();
                            },
                            child: _selectedImage != null
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage: FileImage(_selectedImage!),
                                    child: const Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 14.0,
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 17.0,
                                          color: Color(0xFF404040),
                                        ),
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        NetworkImage(userData!.user_avatar),
                                    child: const Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 14.0,
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 17.0,
                                          color: Color(0xFF404040),
                                        ),
                                      ),
                                    ),
                                  )),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        userData!.name,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userData.email,
                        style: const TextStyle(fontSize: 15),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 40),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: userData.name,
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Họ tên',
                                      fillColor: Colors.grey[200],
                                      prefixIcon: const Icon(Icons.person),
                                      label: const Text('Họ tên')),
                                  validator: (val) => val!.isEmpty
                                      ? 'Vui lòng điền thông tin'
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      _currentName = val;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        child: TextFormField(
                                          decoration:
                                              textInputDecoration.copyWith(
                                                  fillColor: Colors.grey[200],
                                                  label:
                                                      const Text('Ngày sinh'),
                                                  prefixIcon:
                                                      const Icon(Icons.event)),
                                          controller: TextEditingController(
                                              text: DateFormat('MM/dd/yyyy')
                                                  .format(_currentDate ??
                                                      userData.date_of_birth)
                                                  .toString()),
                                          readOnly: true,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        splashRadius: 25,
                                        onPressed: () {
                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  SizedBox(
                                                    height: 250,
                                                    child: CupertinoDatePicker(
                                                      backgroundColor:
                                                          Colors.white,
                                                      initialDateTime: userData
                                                          .date_of_birth,
                                                      onDateTimeChanged:
                                                          (DateTime
                                                              selectedTime) {
                                                        setState(() {
                                                          _currentDate =
                                                              selectedTime;
                                                        });
                                                      },
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .date,
                                                    ),
                                                  ));
                                        },
                                        icon: const Icon(Icons.edit)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                DropdownButtonFormField<String>(
                                  value: userData.gender.isNotEmpty
                                      ? userData.gender
                                      : null,
                                  decoration: textInputDecoration.copyWith(
                                      fillColor: Colors.grey[200],
                                      prefixIcon: const Icon(Icons.transgender),
                                      label: const Text('Giới tính')),
                                  items: genders.map((itemone) {
                                    return DropdownMenuItem(
                                      value: itemone,
                                      child: Text(itemone),
                                    );
                                  }).toList(),
                                  onChanged: (val) =>
                                      setState(() => _currentGender = val!),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  initialValue:
                                      userData.phone_number.toString(),
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Số điện thoại',
                                      prefixIcon: const Icon(Icons.phone),
                                      fillColor: Colors.grey[200],
                                      label: const Text('Số điện thoại')),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  keyboardType: TextInputType.number,
                                  validator: (val) => val!.isEmpty
                                      ? 'Vui lòng điền thông tin'
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      _currentPhone = int.tryParse(val);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  readOnly: true,
                                  initialValue: userData.email,
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Email',
                                      prefixIcon: const Icon(Icons.email),
                                      fillColor: Colors.grey[200],
                                      label: const Text('Email')),
                                  validator: (val) => val!.isEmpty
                                      ? 'Vui lòng điền thông tin'
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      _currentEmail = val;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  initialValue: userData.address,
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Địa chỉ',
                                      prefixIcon: const Icon(Icons.home),
                                      fillColor: Colors.grey[200],
                                      label: const Text('Địa chỉ')),
                                  validator: (val) => val!.isEmpty
                                      ? 'Vui lòng điền thông tin'
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      _currentAddress = val;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (_selectedImage != null) {
                                          final ref = FirebaseStorage.instance
                                              .ref()
                                              .child('${userData.uid}/images')
                                              .child('${DateTime.now()}jpg');
                                          await ref.putFile(_selectedImage!);
                                          downloadURL =
                                              await ref.getDownloadURL();
                                        }
                                        await DatabaseService(uid: user.uid)
                                            .updateUserData(
                                                _currentName ?? userData.name,
                                                _currentGender ??
                                                    userData.gender,
                                                _currentEmail ?? userData.email,
                                                _currentAddress ??
                                                    userData.address,
                                                _currentPhone ??
                                                    userData.phone_number,
                                                _currentDate ??
                                                    userData.date_of_birth,
                                                downloadURL ??
                                                    userData.user_avatar);
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Lưu',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Loading();
            }
          });
    } else {
      return const Loading();
    }
  }
}
