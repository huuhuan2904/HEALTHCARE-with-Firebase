import 'package:flutter/material.dart';
import 'package:project/overview_app_screen.dart';

class HoanTatDatLichScreen extends StatefulWidget {
  const HoanTatDatLichScreen({super.key});

  @override
  State<HoanTatDatLichScreen> createState() => _HoanTatDatLichScreenState();
}

class _HoanTatDatLichScreenState extends State<HoanTatDatLichScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hoàn tất đặt lịch'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Icon(
            Icons.check_circle,
            size: 200,
            color: Colors.green,
          ),
          const Text(
            'Hoàn tất đặt khám!',
            style: TextStyle(fontSize: 20, color: Colors.green),
          ),
          Card(
            margin: EdgeInsets.only(top: 40),
            child: ListTile(
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
                  Row(
                    children: const [
                      Icon(
                        Icons.place,
                        color: Colors.lightBlue,
                      ),
                      const Text('Số 1 Tôn Thất Tùng, Đống Đa, Hà Nội'),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.phone,
                        color: Colors.lightBlue,
                      ),
                      Text(' 9876543210'),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.only(top: 0),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.person,
                          color: Colors.lightBlue,
                        ),
                        Text(' Phạm Hòn Việt')
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.phone,
                          color: Colors.lightBlue,
                        ),
                        Text(' 0123456789')
                      ],
                    ),
                    Wrap(
                      children: const [
                        Icon(
                          Icons.place,
                          color: Colors.lightBlue,
                        ),
                        Text(
                            '35 Nguyễn Đình Chiểu, Lê Đại Hành, Hai Bà Trưng, Hà Nội'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Expanded(
          //   child: Card(
          //     child: Row(
          //       children: [
          //         Container(
          //           alignment: Alignment.bottomLeft,
          //           child: OutlinedButton(
          //             style: OutlinedButton.styleFrom(
          //                 side: BorderSide(color: Colors.purple),
          //                 backgroundColor: Colors.purple,
          //                 shape: const RoundedRectangleBorder(
          //                     borderRadius:
          //                         BorderRadius.all(Radius.circular(10)))),
          //             onPressed: () {
          //               // Navigator.of(context).push(MaterialPageRoute(
          //               //     builder: (context) => HoanTatDatLichScreen()));
          //             },
          //             child: const Text(
          //               'Về trang chủ',
          //               style: TextStyle(fontSize: 20, color: Colors.white),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // )
          SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 50,
                width: 150,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 237, 211, 241),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (contex) => OverViewAppScreen()));
                  },
                  child: const Text(
                    'Về trang chủ',
                    style: TextStyle(fontSize: 20, color: Colors.purple),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      backgroundColor: Colors.purple,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => HoanTatDatLichScreen()));
                  },
                  child: const Text(
                    'Xem lịch hẹn',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
