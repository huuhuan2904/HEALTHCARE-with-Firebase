import 'package:flutter/material.dart';
import 'package:project/screens/admin/admin_view.dart';
import 'package:project/screens/doctor/authenticate/register_doctor.dart';
import 'package:project/screens/doctor/doctor_screens/home_screen_doctor.dart';
import '../../../services/auth.dart';
import '../../../share/constants.dart';
import '../../../share/loading.dart';

class SignInDoctor extends StatefulWidget {
  @override
  _SignInDoctorState createState() => _SignInDoctorState();
}

class _SignInDoctorState extends State<SignInDoctor> {
  final AuthServiceDoctor _auth = AuthServiceDoctor();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  bool _passwordVisible = true;

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
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Image.asset('assets/images/logo.png',
                              fit: BoxFit.cover),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              prefixIcon: const Icon(Icons.email),
                              fillColor: Colors.grey[200],
                            ),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                              prefixIcon: const Icon(Icons.key),
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
                                ? 'Enter more than 6 chars'
                                : null,
                            onChanged: (val) {
                              password = val;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Quên mật khẩu?',
                                    style: TextStyle(color: Colors.orange),
                                  )),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                              child: const Text(
                                'Đăng nhập',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.signInEmailAndPasswordDoctor(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      error =
                                          'Could not sign in with those cedentials';
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
                            height: 12,
                          ),
                          Column(
                            children: [
                              Text(
                                error,
                                style: const TextStyle(color: Colors.red),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Bạn chưa có tài khoản? ',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (contex) =>
                                                  RegisterDoctor()));
                                    },
                                    child: const Text(
                                      'Đăng ký',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 17),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(children: const [
                            Expanded(
                                child: Divider(
                              color: Colors.black,
                            )),
                            Text('Đăng nhập với tư cách là'),
                            Expanded(
                                child: Divider(
                              color: Colors.black,
                            )),
                          ]),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      minimumSize: const Size(130, 45)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.account_circle),
                                  label: const Text(
                                    'Người dùng',
                                    style: TextStyle(fontSize: 18),
                                  )),
                              const Expanded(child: SizedBox()),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      minimumSize: const Size(130, 45)),
                                  onPressed: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AdminView())),
                                  icon: const Icon(Icons.group),
                                  label: const Text(
                                    'Admin',
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ],
                          ),
                          Column(
                            children: [],
                          )
                        ],
                      ))),
            ),
          );
  }
}
