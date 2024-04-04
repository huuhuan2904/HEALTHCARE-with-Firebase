import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../share/loading.dart';
import 'dat_lich_details_screen.dart';
import 'doctor_details.dart';

class DatLichScreen extends StatefulWidget {
  final String userId;
  final String name;
  final int phone_num_user;
  final String address_user;
  final String userAvatar;
  DatLichScreen(this.userId, this.name, this.phone_num_user, this.address_user,
      this.userAvatar);

  @override
  State<DatLichScreen> createState() => _DatLichScreenState();
}

class _DatLichScreenState extends State<DatLichScreen> {
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

  @override
  Widget build(BuildContext context) {
    final CollectionReference doctorCollection =
        FirebaseFirestore.instance.collection('Doctors');
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, bottom: 20, top: 20),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Tên chuyên khoa hoặc bác sĩ',
                  contentPadding: const EdgeInsets.all(8),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: clearText,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: doctorCollection.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    final List<DocumentSnapshot> doctors = streamSnapshot
                        .data!.docs
                        .where((element) => element['name']
                            .toLowerCase()
                            .contains(_search.toLowerCase()))
                        .toList();
                    if (doctors.isEmpty) {
                      return const Center(
                        child: Text(
                          'Không tìm thấy dữ liệu:(',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: doctors.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            doctors[index];
                        return Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                        documentSnapshot['avatar']),
                                  ),
                                  title: Text(
                                    'Bs. ${documentSnapshot['name']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Chuyên khoa: ${documentSnapshot['specialty']}'),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            WidgetSpan(
                                                child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.work_outlined,
                                                  color: Colors.green,
                                                ),
                                                Text(
                                                    ' ${documentSnapshot['years_of_experience']}  '),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                const Text(' 5.0')
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 244, 242, 242),
                                              builder: (_) {
                                                return DoctorDetails(
                                                    documentSnapshot['avatar'],
                                                    documentSnapshot['name'],
                                                    documentSnapshot[
                                                        'phone_number'],
                                                    documentSnapshot['address'],
                                                    documentSnapshot[
                                                        'specialty'],
                                                    documentSnapshot[
                                                        'experiences']);
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DatLichDetailsScreen(
                                                          documentSnapshot.id,
                                                          widget.userId,
                                                          widget.name,
                                                          widget.phone_num_user,
                                                          widget.address_user,
                                                          widget.userAvatar,
                                                          documentSnapshot[
                                                              'name'],
                                                          documentSnapshot[
                                                              'phone_number'],
                                                          documentSnapshot[
                                                              'address'],
                                                          documentSnapshot[
                                                              'avatar'])));
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
                        );
                      },
                    );
                  }
                  return const Loading();
                }),
          ),
        ],
      ),
    );
  }
}
