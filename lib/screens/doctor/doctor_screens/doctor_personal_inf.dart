import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../models/doctor.dart';
import '../../../services/database.dart';
import '../../../share/constants.dart';
import '../../../share/loading.dart';

class DoctorPersonalInf extends StatefulWidget {
  const DoctorPersonalInf({super.key});

  @override
  State<DoctorPersonalInf> createState() => _DoctorPersonalInfState();
}

class _DoctorPersonalInfState extends State<DoctorPersonalInf> {
  List<String> genders = [
    "Nam",
    "Nữ",
    "Khác",
  ];
  List<String> yearsOfExp = [
    "Dưới 1 năm",
    "1 năm",
    "2 năm",
    "3 năm",
    "4 năm",
    "Trên 5 năm",
  ];

  DateTime dateTime = DateTime.now();
  String? _currentName;
  String? _currentGender;
  int? _currentPhone;
  String? _currentAddress;
  DateTime? _currentDate;
  String? exp;
  List _listExp = [];
  List workTime = [];
  String? _currentSpecialty;
  String? _currentYearNum;
  File? _selectedImage;
  String? downloadURL;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  void addList(List doctorData, String doctorId) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: 170,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Form(
                  key: _formKey2,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          prefixIcon: const Icon(Icons.work),
                          hintText: 'Tên doanh nghiệm, thời gian',
                          fillColor: Colors.grey[200],
                        ),
                        onChanged: (value) {
                          setState(() {
                            exp = value;
                          });
                        },
                        validator: (val) =>
                            val!.isEmpty ? 'Vui lòng điền thông tin' : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                        onPressed: () {
                          if (_formKey2.currentState!.validate()) {
                            if (exp != null) {
                              _listExp.add(exp!);
                              _listExp.addAll(doctorData);
                              Navigator.of(context).pop();
                              print(exp);
                            }
                          }
                        },
                        // onPressed: () async {
                        //   if (_formKey2.currentState!.validate()) {
                        //     if (exp != null) {
                        //       await DatabaseServiceDoctor(uid: doctorId)
                        //           .updateArrayExp(exp!);
                        //       Navigator.of(context).pop();
                        //     }
                        //   }
                        // },
                        child:
                            const Text('Thêm', style: TextStyle(fontSize: 17)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

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
    final doctor = Provider.of<MyDoctor>(context);
    return StreamBuilder<DoctorData>(
        stream: DatabaseServiceDoctor(uid: doctor.uid).doctorData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DoctorData? doctorData = snapshot.data;
            return Scaffold(
              backgroundColor: Colors.blue[100],
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
                                    NetworkImage(doctorData!.doctorAvatar),
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
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      doctorData!.name,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      doctorData.email,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Card(
                      color: Colors.blue[100],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 40),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                initialValue: doctorData.name,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Họ tên',
                                    label: const Text('Họ tên'),
                                    prefixIcon: const Icon(Icons.person)),
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
                                                prefixIcon:
                                                    const Icon(Icons.event),
                                                label: const Text('Ngày sinh')),
                                        controller: TextEditingController(
                                            text: DateFormat('dd/MM/yyyy')
                                                .format(_currentDate ??
                                                    doctorData.dateOfBirth)
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
                                                    initialDateTime:
                                                        doctorData.dateOfBirth,
                                                    onDateTimeChanged: (DateTime
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
                                value: doctorData.gender.isNotEmpty
                                    ? doctorData.gender
                                    : null,
                                decoration: textInputDecoration.copyWith(
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
                                initialValue: doctorData.phoneNumber.toString(),
                                decoration: textInputDecoration.copyWith(
                                    prefixIcon: const Icon(Icons.phone),
                                    hintText: 'Số điện thoại',
                                    label: const Text('Số điện thoại')),
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
                                initialValue: doctorData.email,
                                decoration: textInputDecoration.copyWith(
                                    prefixIcon: const Icon(Icons.email),
                                    hintText: 'Email',
                                    label: const Text('Email')),
                                validator: (val) => val!.isEmpty
                                    ? 'Vui lòng điền thông tin'
                                    : null,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                initialValue: doctorData.address,
                                decoration: textInputDecoration.copyWith(
                                    prefixIcon: const Icon(Icons.home),
                                    hintText: 'Địa chỉ',
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
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 13, left: 13),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.work,
                                            color: Colors.purple,
                                          ),
                                          const Expanded(
                                            child: Text(
                                              '  Kinh nghiệm',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.purple),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () => {
                                                    addList(
                                                        doctorData.doctorExp,
                                                        doctor.uid),
                                                  },
                                              icon: const Icon(Icons.add))
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: _listExp.isEmpty
                                          ? doctorData.doctorExp.length
                                          : _listExp.length,
                                      separatorBuilder: (_, __) =>
                                          const Divider(
                                        color: Colors.grey,
                                      ),
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: const Icon(
                                            Icons.work_outline,
                                            color: Colors.purple,
                                          ),
                                          title: Text(_listExp.isEmpty
                                              ? doctorData.doctorExp[index]
                                              : _listExp[index]),
                                          trailing: IconButton(
                                              onPressed: () async {
                                                await DatabaseServiceDoctor(
                                                        uid: doctor.uid)
                                                    .removeArrayExp(doctorData
                                                        .doctorExp[index]);
                                              },
                                              icon: const Icon(Icons.close)),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              DropdownButtonFormField<String>(
                                value: doctorData.expNum.isNotEmpty
                                    ? doctorData.expNum
                                    : null,
                                decoration: textInputDecoration.copyWith(
                                    prefixIcon: const Icon(Icons.transgender),
                                    label: const Text('Số kinh nghiệm')),
                                items: yearsOfExp.map((itemone) {
                                  return DropdownMenuItem(
                                    value: itemone,
                                    child: Text(itemone),
                                  );
                                }).toList(),
                                onChanged: (val) =>
                                    setState(() => _currentYearNum = val!),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                initialValue: doctorData.specialty,
                                decoration: textInputDecoration.copyWith(
                                    prefixIcon: const Icon(Icons.description),
                                    hintText: 'Chuyên khoa',
                                    label: const Text('Chuyên khoa')),
                                validator: (val) => val!.isEmpty
                                    ? 'Vui lòng điền thông tin'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    _currentSpecialty = val;
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
                                            .child('${doctorData.name}/images')
                                            .child('${DateTime.now()}jpg');
                                        await ref.putFile(_selectedImage!);
                                        downloadURL =
                                            await ref.getDownloadURL();
                                      }
                                      if (_listExp.isEmpty) {
                                        _listExp.addAll(doctorData.doctorExp);
                                      }
                                      await DatabaseServiceDoctor(
                                              uid: doctor.uid)
                                          .updateDoctorData(
                                              _currentName ?? doctorData.name,
                                              _currentGender ??
                                                  doctorData.gender,
                                              doctorData.email,
                                              _currentAddress ??
                                                  doctorData.address,
                                              _currentPhone ??
                                                  doctorData.phoneNumber,
                                              _currentDate ??
                                                  doctorData.dateOfBirth,
                                              _listExp,
                                              _currentYearNum ??
                                                  doctorData.expNum,
                                              _currentSpecialty ??
                                                  doctorData.specialty,
                                              downloadURL ??
                                                  doctorData.doctorAvatar);
                                      // await DatabaseServiceDoctor(
                                      //         uid: doctor.uid)
                                      //     .updateArrayExp(exp!);

                                      print(_listExp);
                                      Navigator.of(context).pop();
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
            return Loading();
          }
        });
    return Loading();
  }
}
