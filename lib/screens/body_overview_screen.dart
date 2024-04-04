import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project/models/user.dart';
import 'package:project/share/loading.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../services/database.dart';
import 'dat_lich_screen.dart';
import 'lich_kham_screen.dart';
import 'lich_su_kham_screen.dart';

class BodyOverviewScreen extends StatefulWidget {
  const BodyOverviewScreen({super.key});

  @override
  State<BodyOverviewScreen> createState() => _BodyOverviewScreenState();
}

class _BodyOverviewScreenState extends State<BodyOverviewScreen> {
  Widget buildServiceGridview(BuildContext context, String title, IconData icon,
      Function() tapHandler) {
    return InkWell(
      onTap: tapHandler,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.purple,
            ),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  int _currentIndex = 0;
  final List<String> imagesList = [
    'assets/images/ad_main.png',
    'assets/images/ad_main.png',
    'assets/images/ad_main.png',
    'assets/images/ad_main.png',
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    if (user != null) {
      return StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData? userData = snapshot.data;
              return Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Chào'),
                                Row(
                                  children: [
                                    Text(
                                      userData!.name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Icon(
                                      Icons.waving_hand_sharp,
                                      color: Colors.yellow,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(userData.user_avatar),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 250,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        autoPlay: true,
                      ),
                      items: imagesList
                          .map(
                            (item) => Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Image.asset(
                                  item,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: _currentIndex,
                    count: imagesList.length,
                    effect: const WormEffect(
                        dotWidth: 12,
                        dotHeight: 12,
                        activeDotColor: Colors.blue),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GridView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        children: [
                          buildServiceGridview(context, 'Đặt lịch',
                              Icons.medical_services_outlined, () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DatLichScreen(
                                    user.uid,
                                    userData.name,
                                    userData.phone_number,
                                    userData.address,
                                    userData.user_avatar)));
                          }),
                          buildServiceGridview(
                              context, 'Lịch khám', Icons.event, () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    LichKhamScreen(user.uid)));
                          }),
                          buildServiceGridview(
                              context, 'Thuốc', Icons.catching_pokemon_outlined,
                              () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const LichSuKhamScreen()));
                          }),
                          buildServiceGridview(
                              context, 'Hỗ trợ', Icons.support_agent_outlined,
                              () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const LichSuKhamScreen()));
                          }),
                        ]),
                  )
                ],
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
