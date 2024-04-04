import 'package:flutter/material.dart';
import 'package:project/screens/admin/list_user.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

Widget _buildList(String name) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: () {},
        child: Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        )),
  );
}

class _AdminViewState extends State<AdminView> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              centerTitle: true,
              title: const Text('ADMIN'),
              bottom: const TabBar(
                indicatorWeight: 3,
                tabs: [
                  Tab(
                    icon: Icon(Icons.person_outline),
                    text: 'User',
                  ),
                  Tab(
                    icon: ImageIcon(AssetImage(
                      'assets/images/icon_doctor.png',
                    )),
                    text: 'Doctor',
                  ),
                  Tab(
                    icon: Icon(Icons.medical_information_outlined),
                    text: 'Medicine',
                  ),
                ],
              ),
            ),
            body: const TabBarView(children: [
              ListUser(),
              Text('doctor'),
              Text('medicine'),
            ])),
      );
}
