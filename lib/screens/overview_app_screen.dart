import 'package:flutter/material.dart';
import 'package:project/models/user.dart';
import 'package:project/screens/authenticate/authenticate.dart';
import 'package:project/screens/thong_bao_screen.dart';
import 'package:project/screens/user_personal_inf.dart';
import 'package:project/services/database.dart';
import 'package:project/share/loading.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';
import 'body_overview_screen.dart';
import 'cai_dat_screen.dart';
import 'lich_kham_screen.dart';
import 'lich_su_kham_screen.dart';

class OverViewAppScreen extends StatefulWidget {
  @override
  State<OverViewAppScreen> createState() => _OverViewAppScreenState();
}

class _OverViewAppScreenState extends State<OverViewAppScreen> {
  final AuthService _auth = AuthService();
  late final List<Map<String, Object>> _pages = [
    {'page': const BodyOverviewScreen(), 'title': 'Trang chủ'},
    {'page': const LichSuKhamScreen(), 'title': 'Lịch khám'},
    {'page': const ThongBaoScreen(), 'title': 'Thông báo'},
    {'page': const CaiDatScreen(), 'title': 'Cài đặt'}
  ];

  int _selectedPageIndex = 0;

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

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
                  title: Text(_pages[_selectedPageIndex]['title'] as String),
                ),
                drawer: Drawer(
                  child: Column(
                    children: [
                      Container(
                        height: 230,
                        padding: const EdgeInsets.only(top: 50),
                        color: Theme.of(context).colorScheme.secondary,
                        child: Column(
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    NetworkImage(userData!.user_avatar),
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              userData.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              userData.email,
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
                              builder: (context) => const UserPersonalInf()));
                        },
                      ),
                      const Divider(),
                      buildBodyDrawer(Icons.settings_outlined, 'Cài đặt'),
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
                body: _pages[_selectedPageIndex]['page'] as Widget,
                bottomNavigationBar: BottomNavigationBar(
                    selectedItemColor: Colors.purple,
                    unselectedItemColor: Colors.black,
                    currentIndex: _selectedPageIndex,
                    onTap: selectPage,
                    type: BottomNavigationBarType.fixed,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Trang chủ',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.calendar_today),
                        label: 'Lịch khám',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.notifications),
                        label: 'Thông báo',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: 'Cài đặt',
                      ),
                    ]),
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
