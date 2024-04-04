import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'overview_app_screen.dart';

class HoanTatDatLichScreen extends StatefulWidget {
  final DateTime datechosen;
  final TimeOfDay timechosen;
  final String userName;
  final int userPhoneNum;
  final String userAddress;
  final String doctorName;
  final int doctorPhoneNum;
  final String doctorAddress;
  final String doctorAvatar;
  const HoanTatDatLichScreen(
      this.datechosen,
      this.timechosen,
      this.userName,
      this.userPhoneNum,
      this.userAddress,
      this.doctorName,
      this.doctorPhoneNum,
      this.doctorAddress,
      this.doctorAvatar,
      {super.key});

  @override
  State<HoanTatDatLichScreen> createState() => _HoanTatDatLichScreenState();
}

class _HoanTatDatLichScreenState extends State<HoanTatDatLichScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoàn tất đặt lịch'),
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
          Text(
            'Ngày khám: ${DateFormat.yMd().format(widget.datechosen)}',
            style: const TextStyle(fontSize: 27),
          ),
          Text(
            'Giờ khám: ${widget.timechosen.format(context).toString()}',
            style: const TextStyle(fontSize: 27),
          ),
          Card(
            margin: const EdgeInsets.only(top: 40),
            child: ListTile(
              isThreeLine: true,
              leading: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(widget.doctorAvatar),
                  child: Text('')),
              title: Text(
                'BS. ${widget.doctorName}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.place,
                        color: Colors.lightBlue,
                      ),
                      Text(widget.doctorAddress),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: Colors.lightBlue,
                      ),
                      Text(' ${widget.doctorPhoneNum}'),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Card(
              margin: const EdgeInsets.only(top: 0),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                        ),
                        Text(' ${widget.userName}')
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                        ),
                        Text(' ${widget.userPhoneNum}')
                      ],
                    ),
                    Wrap(
                      children: [
                        const Icon(
                          Icons.place,
                        ),
                        Text(widget.userAddress),
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
          const SizedBox(
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
                      backgroundColor: const Color.fromARGB(255, 237, 211, 241),
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
                      side: const BorderSide(color: Colors.purple),
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
