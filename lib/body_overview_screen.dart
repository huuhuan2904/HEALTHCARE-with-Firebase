import 'package:flutter/material.dart';
import 'package:project/dat_lich_screen.dart';

class BodyOverviewScreen extends StatelessWidget {
  const BodyOverviewScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
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
                        children: const [
                          Text(
                            'Phạm Hòn Việt  ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.waving_hand_sharp,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://scontent.fsgn14-1.fna.fbcdn.net/v/t1.15752-9/324220059_3476629519237918_5671512060780998457_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=ae9488&_nc_ohc=wDy5UrBnrPAAX8Jw8bJ&_nc_ht=scontent.fsgn14-1.fna&oh=03_AdRyouDMW2yAfbeRhH2r1rXxbrjvMNHmExCS01OA3_cwng&oe=64811BEB'),
                    child: Text(''))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Container(
            height: 200,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Image.asset(
                'assets/images/ad_main.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: GridView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              children: [
                buildServiceGridview(
                    context, 'Đặt lịch', Icons.medical_services_outlined, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DatLichScreen()));
                }),
                buildServiceGridview(context, 'Lịch sử khám', Icons.event, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DatLichScreen()));
                }),
                buildServiceGridview(
                    context, 'Thuốc', Icons.catching_pokemon_outlined, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DatLichScreen()));
                }),
                buildServiceGridview(
                    context, 'Hỗ trợ', Icons.support_agent_outlined, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DatLichScreen()));
                }),
              ]),
        )
      ],
    );
  }
}
