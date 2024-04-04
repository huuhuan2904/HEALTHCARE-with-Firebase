import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/share/loading.dart';

class LichSuKhamScreen extends StatefulWidget {
  const LichSuKhamScreen({super.key});

  @override
  State<LichSuKhamScreen> createState() => _LichSuKhamScreenState();
}

class _LichSuKhamScreenState extends State<LichSuKhamScreen> {
  final CollectionReference _appointmentCollection =
      FirebaseFirestore.instance.collection('Appointments');
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(
    //       centerTitle: true,
    //       title: const Text('Lịch sử khám'),
    //     ),
    //     body: Column(
    //       children: [
    //         Expanded(
    //             child: StreamBuilder(
    //                 stream: _appointmentCollection.snapshots(),
    //                 builder:
    //                     (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
    //                   if (streamSnapshot.hasData) {
    //                     final List<DocumentSnapshot> _appointments =
    //                         streamSnapshot.data!.docs
    //                             .where((element) =>
    //                                 element['user_id'].contains('id'))
    //                             .toList();
    //                     if (_appointments.isEmpty) {
    //                       return const Center(
    //                         child: Text(
    //                           'Không tìm thấy dữ liệu:(',
    //                           style: TextStyle(fontSize: 20),
    //                         ),
    //                       );
    //                     }
    //                     return ListView.builder(
    //                         itemCount: _appointments.length,
    //                         itemBuilder: (context, index) {
    //                           final DocumentSnapshot documentSnapshot =
    //                               _appointments[index];
    //                           return Card(
    //                             color: const Color.fromARGB(255, 88, 136, 190),
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(20),
    //                             ),
    //                             margin: const EdgeInsets.all(10),
    //                             child: ListTile(
    //                               leading: CircleAvatar(
    //                                 radius: 30,
    //                                 backgroundImage: NetworkImage(
    //                                     documentSnapshot['user_avatar']),
    //                               ),
    //                               title: Text(
    //                                 'Ngày khám: ${DateFormat('MM/dd/yyyy').format(documentSnapshot['booking_date'].toDate())}',
    //                                 style: const TextStyle(
    //                                     fontWeight: FontWeight.bold,
    //                                     color: Colors.white),
    //                               ),
    //                               subtitle: Text(
    //                                 ' ${documentSnapshot['booking_time']}  ',
    //                                 style: const TextStyle(color: Colors.white),
    //                               ),
    //                             ),
    //                           );
    //                         });
    //                   }
    //                   return const Loading();
    //                 }))
    //       ],
    //     ));
    return Container(
      child: const Text('hi'),
    );
  }
}
