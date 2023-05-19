import 'package:flutter/material.dart';
import 'package:project/dat_lich_details_screen.dart';
import 'package:project/doctor_details.dart';

class DatLichScreen extends StatelessWidget {
  const DatLichScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'ĐẶT LỊCH',
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.purple,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, bottom: 40, top: 20),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  hintText: 'Tên chuyên khoa hoặc bác sĩ...',
                  hintStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  isThreeLine: true,
                  leading: const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          'https://cdn.cpdonline.co.uk/wp-content/uploads/2021/07/28125941/Doctors-CPD-couses.png'),
                      child: Text('')),
                  title: const Text(
                    'BS. Nguyễn Văn A',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Chuyên khoa: tim mạch, xương khớp'),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                                child: Row(
                              children: const [
                                Icon(
                                  Icons.work_outlined,
                                  color: Colors.green,
                                ),
                                Text(' 3 năm  '),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Text(' 5.0')
                              ],
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            minimumSize: Size(150, 45)),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor:
                                  const Color.fromARGB(255, 244, 242, 242),
                              builder: (_) {
                                return DoctorDetails();
                              });
                        },
                        icon: const Icon(Icons.search),
                        label: const Text(
                          'Chi tiết',
                          style: TextStyle(fontSize: 18),
                        )),
                    const SizedBox(
                      width: 33,
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            minimumSize: Size(150, 45)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DatLichDetailsScreen()));
                        },
                        icon: const Icon(Icons.event),
                        label: const Text(
                          'Đặt lịch',
                          style: TextStyle(fontSize: 18),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
