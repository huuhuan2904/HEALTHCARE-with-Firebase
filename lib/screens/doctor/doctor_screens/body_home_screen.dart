import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/screens/doctor/doctor_screens/detail_booking.dart';

import '../../../share/loading.dart';

class BodyHomeScreen extends StatefulWidget {
  final String id;
  BodyHomeScreen(this.id);

  @override
  State<BodyHomeScreen> createState() => _BodyHomeScreenState();
}

class _BodyHomeScreenState extends State<BodyHomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  String _search = '';
  void _onSearchChanged(String value) {
    setState(() {
      _search = value;
    });
  }

  void clearText() {
    _searchController.clear();
  }

  Future<void> check(String docId) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Lưu ý"),
        content: const Text(
          "Bạn có chắc chắn người này đã đến khám?",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await _appointmentCollection.doc(docId).update({"status": true});
              Navigator.of(ctx).pop();
            },
            child: Container(
              child: const Text(
                "Có",
                style: TextStyle(color: Colors.cyan, fontSize: 17),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              child: const Text(
                "Hủy",
                style: TextStyle(color: Colors.cyan, fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final CollectionReference _appointmentCollection =
      FirebaseFirestore.instance.collection('Appointments');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: StreamBuilder(
                stream: _appointmentCollection.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    final List<DocumentSnapshot> _appointments = streamSnapshot
                        .data!.docs
                        .where((element) =>
                            element['doctor_id'].contains(widget.id))
                        .toList();
                    if (_appointments.isEmpty) {
                      return const Center(
                        child: Text(
                          'Không tìm thấy dữ liệu:(',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: _appointments.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              _appointments[index];
                          return Card(
                            color: Colors.grey[100],
                            shadowColor: documentSnapshot['status']
                                ? Colors.green
                                : Colors.red,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: const EdgeInsets.all(10),
                            // child: ListTile(
                            //   leading: CircleAvatar(
                            //     radius: 30,
                            //     backgroundImage: NetworkImage(
                            //         documentSnapshot['user_avatar']),
                            //   ),
                            //   title: Text(
                            //     'Ngày khám: ${DateFormat('MM/dd/yyyy').format(documentSnapshot['booking_date'].toDate())}',
                            //     style: const TextStyle(
                            //         fontWeight: FontWeight.bold),
                            //   ),
                            //   subtitle: Text(
                            //     'Giờ khám: ${documentSnapshot['booking_time']}',
                            //   ),
                            //   // trailing: documentSnapshot['status']
                            //   //     ? const Text(
                            //   //         'Đã khám',
                            //   //         style: TextStyle(
                            //   //             color: Colors.green,
                            //   //             fontWeight: FontWeight.bold),
                            //   //       )
                            //   //     : const Text(
                            //   //         'Chưa khám',
                            //   //         style: TextStyle(
                            //   //             color: Colors.red,
                            //   //             fontWeight: FontWeight.bold
                            //   //             ),
                            //   //       ),
                            //   trailing: TextButton(
                            //       onPressed: () => {},
                            //       child: documentSnapshot['status']
                            //           ? const Text(
                            //               'Đã khám',
                            //               style: TextStyle(
                            //                   color: Colors.green,
                            //                   fontWeight: FontWeight.bold),
                            //             )
                            //           : const Text(
                            //               'Chưa khám',
                            //               style: TextStyle(
                            //                   color: Colors.red,
                            //                   fontWeight: FontWeight.bold),
                            //             )),
                            // ),
                            child: SwitchListTile(
                                isThreeLine: true,
                                title: Text(
                                  'Anh(chị): ${documentSnapshot['user_name']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                value: documentSnapshot['status'],
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ngày khám: ${DateFormat('MM/dd/yyyy').format(documentSnapshot['booking_date'].toDate())}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Giờ khám: ${documentSnapshot['booking_time']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                inactiveThumbColor: Colors.red,
                                activeTrackColor: Colors.green[200],
                                activeColor: Colors.green,
                                inactiveTrackColor: Colors.red[200],
                                activeThumbImage: const NetworkImage(
                                    'https://banner2.cleanpng.com/20180314/bse/kisspng-check-mark-tick-clip-art-green-tick-mark-5aa8e456cec986.968665711521017942847.jpg'),
                                inactiveThumbImage: const NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5fQIkdrwnhcB5bkqZGamz8c06NWJEbn5iXg&usqp=CAU'),
                                onChanged: (value) {
                                  check(documentSnapshot.id);
                                }),
                          );
                        });
                  }
                  return const Loading();
                }))
      ],
    );

    // final CollectionReference doctorCollection =
    //     FirebaseFirestore.instance.collection('Doctors');
    // final CollectionReference doctorSubCollection = FirebaseFirestore.instance
    //     .collection('Doctors')
    //     .doc(widget.id)
    //     .collection('Medical_examination_history');
    // return Column(
    //   children: [
    //     Container(
    //       color: Colors.blue,
    //       child: Padding(
    //         padding:
    //             const EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 20),
    //         child: TextField(
    //           controller: _searchController,
    //           onChanged: _onSearchChanged,
    //           decoration: InputDecoration(
    //             fillColor: Colors.white,
    //             filled: true,
    //             hintText: 'Tên chuyên khoa hoặc bác sĩ',
    //             contentPadding: const EdgeInsets.all(8),
    //             prefixIcon: const Padding(
    //               padding: EdgeInsets.only(left: 10),
    //               child: Icon(
    //                 Icons.search,
    //                 size: 30,
    //               ),
    //             ),
    //             suffixIcon: IconButton(
    //               icon: const Icon(Icons.clear),
    //               onPressed: clearText,
    //             ),
    //             border:
    //                 OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
    //           ),
    //         ),
    //       ),
    //     ),
    //     Expanded(
    //       child: StreamBuilder(
    //           stream: doctorCollection.snapshots(),
    //           builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
    //             if (streamSnapshot.hasData) {
    //               return StreamBuilder(
    //                   stream: doctorSubCollection.snapshots(),
    //                   builder: (context,
    //                       AsyncSnapshot<QuerySnapshot> streamSnapshot) {
    //                     if (streamSnapshot.hasData) {
    //                       final List<DocumentSnapshot> doctors =
    //                           streamSnapshot.data!.docs;
    //                       return ListView.builder(
    //                         itemCount: doctors.length,
    //                         itemBuilder: (context, index) {
    //                           if (doctors.isNotEmpty) {
    //                             final DocumentSnapshot documentSnapshot =
    //                                 doctors[index];
    //                             return Card(
    //                               color:
    //                                   const Color.fromARGB(255, 255, 255, 255),
    //                               shape: RoundedRectangleBorder(
    //                                 borderRadius: BorderRadius.circular(20),
    //                               ),
    //                               margin: const EdgeInsets.all(10),
    //                               child: Padding(
    //                                 padding: const EdgeInsets.all(15),
    //                                 child: Column(
    //                                   children: [
    //                                     ListTile(
    //                                       leading: CircleAvatar(
    //                                         radius: 40,
    //                                         backgroundImage: NetworkImage(
    //                                             documentSnapshot[
    //                                                 'user_avatar']),
    //                                       ),
    //                                       title: Text(
    //                                         'Anh(chị): ${documentSnapshot['user_name']}',
    //                                         style: const TextStyle(
    //                                             fontWeight: FontWeight.bold,
    //                                             color: Colors.black),
    //                                       ),
    //                                       subtitle: Column(
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: [
    //                                           Text(
    //                                               'Ngày khám: ${DateFormat('MM/dd/yyyy').format(documentSnapshot['booking_date'].toDate())}'),
    //                                           Text.rich(
    //                                             TextSpan(
    //                                               children: [
    //                                                 WidgetSpan(
    //                                                     child: Row(
    //                                                   children: [
    //                                                     const Icon(
    //                                                       Icons.timelapse,
    //                                                       color: Colors.green,
    //                                                     ),
    //                                                     Text(
    //                                                         ' ${documentSnapshot['booking_time']}  '),
    //                                                   ],
    //                                                 )),
    //                                               ],
    //                                             ),
    //                                           )
    //                                         ],
    //                                       ),
    //                                     ),
    //                                     Row(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.center,
    //                                       children: [
    //                                         ElevatedButton.icon(
    //                                             style: ElevatedButton.styleFrom(
    //                                               shape: RoundedRectangleBorder(
    //                                                   borderRadius:
    //                                                       BorderRadius.circular(
    //                                                           20)),
    //                                             ),
    //                                             onPressed: () {
    //                                               showModalBottomSheet(
    //                                                   context: context,
    //                                                   backgroundColor:
    //                                                       const Color.fromARGB(
    //                                                           255,
    //                                                           244,
    //                                                           242,
    //                                                           242),
    //                                                   builder: (_) {
    //                                                     return Detail_booking(
    //                                                       documentSnapshot[
    //                                                           'user_name'],
    //                                                       documentSnapshot[
    //                                                           'user_phone_num'],
    //                                                       documentSnapshot[
    //                                                           'user_address'],
    //                                                       documentSnapshot[
    //                                                               'booking_date']
    //                                                           .toDate(),
    //                                                       documentSnapshot[
    //                                                           'booking_time'],
    //                                                       documentSnapshot[
    //                                                               'date']
    //                                                           .toDate(),
    //                                                     );
    //                                                   });
    //                                             },
    //                                             icon: const Icon(Icons.search),
    //                                             label: const Text(
    //                                               'Chi tiết',
    //                                               style:
    //                                                   TextStyle(fontSize: 18),
    //                                             )),
    //                                         const SizedBox(
    //                                           width: 33,
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                             );
    //                           } else {
    //                             return const Center(
    //                               child: Text('Khong co ai dat'),
    //                             );
    //                           }
    //                         },
    //                       );
    //                     } else {
    //                       return const Loading();
    //                     }
    //                   });
    //             } else {
    //               return const Loading();
    //             }
    //           }),
    //     ),
    //   ],
    // );
  }
}
