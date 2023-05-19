import 'package:flutter/material.dart';
import 'package:project/body_overview_screen.dart';

class OverViewAppScreen extends StatelessWidget {
  const OverViewAppScreen({super.key});

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Trang chủ'),
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.settings), onPressed: () {}),
        // ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 230,
              padding: EdgeInsets.only(top: 50),
              color: Theme.of(context).accentColor,
              child: Column(
                children: const [
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://scontent.fsgn14-1.fna.fbcdn.net/v/t1.15752-9/324220059_3476629519237918_5671512060780998457_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=ae9488&_nc_ohc=wDy5UrBnrPAAX8Jw8bJ&_nc_ht=scontent.fsgn14-1.fna&oh=03_AdRyouDMW2yAfbeRhH2r1rXxbrjvMNHmExCS01OA3_cwng&oe=64811BEB'),
                      child: Align(
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
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    'Phạm Hòn Việt',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  Text(
                    'vietpham@gmail.com',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            buildBodyDrawer(Icons.account_circle, 'Hồ sơ cá nhân'),
            const Divider(),
            buildBodyDrawer(Icons.settings_outlined, 'Cài đặt'),
            const Divider(),
            buildBodyDrawer(Icons.delete_outline, 'Xóa tài khoản'),
            const Divider(),
            buildBodyDrawer(Icons.logout_outlined, 'Đăng xuất'),
          ],
        ),
      ),
      body: BodyOverviewScreen(),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: 'Lịch khám'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Thông báo'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Cài đặt'),
          ]),
    );
  }
}
