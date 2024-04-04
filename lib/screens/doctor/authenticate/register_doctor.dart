import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project/screens/doctor/authenticate/sign_in_doctor.dart';
import 'package:project/screens/doctor/doctor_screens/home_screen_doctor.dart';
import '../../../services/auth.dart';
import '../../../share/constants.dart';
import '../../../share/loading.dart';

class RegisterDoctor extends StatefulWidget {
  @override
  State<RegisterDoctor> createState() => _RegisterDoctorState();
}

class _RegisterDoctorState extends State<RegisterDoctor> {
  final AuthServiceDoctor _auth = AuthServiceDoctor();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  bool _passwordVisible = true;
  DateTime dateTime = DateTime.now();
  List<String> genders = [
    "Nam",
    "Nữ",
    "Khác",
  ];
  String? _currentName;
  String? _currentGender;
  var _currentPhone;
  String? _currentAddress;
  DateTime? _currentDate;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.blue[100],
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50.0, horizontal: 45),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                fillColor: Colors.grey[200], hintText: 'Tên'),
                            validator: (val) =>
                                val!.isEmpty ? 'Vui lòng nhập tên' : null,
                            onChanged: (val) {
                              setState(() {
                                _currentName = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            child: TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Ngày sinh',
                                  fillColor: Colors.grey[200],
                                  label: const Text('Ngày sinh')),
                              controller: TextEditingController(
                                  text: DateFormat('MM/dd/yyyy')
                                      .format(dateTime)
                                      .toString()),
                              enabled: false,
                            ),
                            onTap: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) => SizedBox(
                                        height: 250,
                                        child: CupertinoDatePicker(
                                          backgroundColor: Colors.white,
                                          initialDateTime: dateTime,
                                          onDateTimeChanged:
                                              (DateTime selectedTime) {
                                            setState(() {
                                              _currentDate = selectedTime;
                                            });
                                          },
                                          mode: CupertinoDatePickerMode.date,
                                        ),
                                      ));
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField<String>(
                            value: _currentGender,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Giới tính',
                                fillColor: Colors.grey[200],
                                label: const Text('Giới tính')),
                            items: genders.map((itemone) {
                              return DropdownMenuItem(
                                value: itemone,
                                child: Text(itemone),
                              );
                            }).toList(),
                            onChanged: (val) =>
                                setState(() => {_currentGender = val!}),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                fillColor: Colors.grey[200],
                                hintText: 'Số điện thoại'),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            validator: (val) => val!.isEmpty
                                ? 'Vui lòng nhập số điện thoại'
                                : null,
                            onChanged: (val) {
                              setState(() {
                                _currentPhone = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                fillColor: Colors.grey[200],
                                hintText: 'Địa chỉ'),
                            validator: (val) =>
                                val!.isEmpty ? 'Vui lòng nhập địa chỉ' : null,
                            onChanged: (val) {
                              setState(() {
                                _currentAddress = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              fillColor: Colors.grey[200],
                            ),
                            validator: (val) =>
                                val!.isEmpty ? 'Vui lòng nhập email' : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              hintText: 'Password',
                              fillColor: Colors.grey[200],
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                child: Icon(
                                  _passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            obscureText: _passwordVisible,
                            validator: (val) => val!.length < 6
                                ? 'Mật khẩu phải nhiều hơn 6 kí tự'
                                : null,
                            onChanged: (val) {
                              password = val;
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                              child: const Text(
                                'Đăng ký',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result = await _auth
                                      .registerWithEmailAndPasswordDoctor(
                                          email,
                                          password,
                                          _currentName ?? "",
                                          _currentGender ?? "",
                                          int.parse(_currentPhone),
                                          _currentAddress ?? "",
                                          _currentDate ?? dateTime,
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoLm3XaM3Q3cr6UnbgEpOfV0AH0ZTj6-ioSgh8l_UF7l01I3XbaZ84OaGw0VEq3QvYdYE&usqp=CAU');
                                  if (result == null) {
                                    setState(() {
                                      error = 'Please supply a valid email';
                                      loading = false;
                                    });
                                  } else {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreenDoctor()));
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[400],
                              ),
                              child: const Text(
                                'Quay về đăng nhập',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (contex) => SignInDoctor()));
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ))),
            ),
          );
  }
}
