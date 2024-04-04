import 'package:flutter/material.dart';
import 'package:project/models/doctor.dart';
import 'package:project/screens/doctor/doctor_screens/body_home_screen.dart';
import 'package:project/screens/doctor/doctor_screens/doctor_personal_inf.dart';
import 'package:project/screens/doctor/doctor_screens/work_schedule.dart';
import 'package:project/services/auth.dart';
import 'package:project/services/database.dart';
import 'package:project/share/loading.dart';
import 'package:provider/provider.dart';
import '../../authenticate/authenticate.dart';

class HomeScreenDoctor extends StatefulWidget {
  const HomeScreenDoctor({super.key});

  @override
  State<HomeScreenDoctor> createState() => _HomeScreenDoctorState();
}

class _HomeScreenDoctorState extends State<HomeScreenDoctor> {
  final AuthServiceDoctor _auth = AuthServiceDoctor();
  Widget buildBodyDrawer(IconData icon, String title) {
    return ListTile(
      leading: Icon(
        icon,
        size: 40,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<MyDoctor>(context);
    if (doctor != null) {
      return StreamBuilder<DoctorData>(
          stream: DatabaseServiceDoctor(uid: doctor.uid).doctorData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              DoctorData? doctorData = snapshot.data;
              return Scaffold(
                appBar: AppBar(),
                drawer: Drawer(
                  child: Column(
                    children: [
                      Container(
                        height: 230,
                        padding: const EdgeInsets.only(top: 50),
                        color: Theme.of(context).accentColor,
                        child: Column(
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    NetworkImage(doctorData!.doctorAvatar),
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              doctorData.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              doctorData.email,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.account_circle,
                          size: 40,
                        ),
                        title: const Text(
                          'Hồ sơ cá nhân',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onTap: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const DoctorPersonalInf()));
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(
                          Icons.calendar_today,
                          size: 40,
                        ),
                        title: const Text(
                          'Lịch làm việc',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onTap: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const WorkSchedule()));
                        },
                      ),
                      const Divider(),
                      buildBodyDrawer(Icons.delete_outline, 'Xóa tài khoản'),
                      const Divider(),
                      ListTile(
                        leading: const Icon(
                          Icons.logout_outlined,
                          size: 40,
                        ),
                        title: const Text(
                          'Đăng xuất',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onTap: () async {
                          await _auth.signOutAnon();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Authenticate()));
                        },
                      ),
                    ],
                  ),
                ),
                body: BodyHomeScreen(doctor.uid),
              );
            } else {
              print(doctor.uid);
              return const Loading();
            }
          });
    } else {
      return const Loading();
    }
  }
}
