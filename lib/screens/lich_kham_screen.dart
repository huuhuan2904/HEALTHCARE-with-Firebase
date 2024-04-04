import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../share/loading.dart';

class LichKhamScreen extends StatefulWidget {
  final String userId;
  LichKhamScreen(this.userId);
  @override
  State<LichKhamScreen> createState() => _LichKhamScreenState();
}

class _LichKhamScreenState extends State<LichKhamScreen> {
  final CollectionReference _appointmentCollection =
      FirebaseFirestore.instance.collection('Appointments');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Lịch khám'),
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: _appointmentCollection.snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        final List<DocumentSnapshot> _appointments =
                            streamSnapshot.data!.docs
                                .where((element) =>
                                    element['user_id'].contains(widget.userId))
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: const EdgeInsets.all(10),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        documentSnapshot['user_avatar']),
                                  ),
                                  title: Text(
                                    'Ngày khám: ${DateFormat('MM/dd/yyyy').format(documentSnapshot['booking_date'].toDate())}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'Giờ khám: ${documentSnapshot['booking_time']}',
                                  ),
                                  trailing: documentSnapshot['status']
                                      ? const Text(
                                          'Đã khám',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : const Text(
                                          'Chưa khám',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ),
                              );
                            });
                      }
                      return const Loading();
                    }))
          ],
        ));
  }
}
