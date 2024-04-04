import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/share/loading.dart';

import '../../share/constants.dart';

class ListUser extends StatefulWidget {
  const ListUser({super.key});

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  String? _currentName;
  String? _currentGender;
  int? _currentPhone;
  String? _currentAddress;
  DateTime? _currentDate;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();

  List<String> genders = [
    "Nam",
    "Nữ",
    "Khác",
  ];

  String _search = '';
  void _onSearchChanged(String value) {
    setState(() {
      _search = value;
    });
  }

  void clearText() {
    _searchController.clear();
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 10,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Update your item",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: documentSnapshot!['name'],
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Họ tên',
                              fillColor: Colors.grey[200],
                              label: const Text('Họ tên')),
                          validator: (val) =>
                              val!.isEmpty ? 'Vui lòng điền thông tin' : null,
                          onChanged: (val) {
                            setState(() {
                              _currentName = val;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          child: TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Ngày sinh',
                                fillColor: Colors.grey[200],
                                label: const Text('Ngày sinh')),
                            controller: TextEditingController(
                                text: DateFormat('MM/dd/yyyy')
                                    .format(documentSnapshot['date_of_birth']
                                        .toDate())
                                    .toString()),
                            enabled: false,
                          ),
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) => SizedBox(
                                      height: 250,
                                      child: CupertinoDatePicker(
                                        backgroundColor: Colors.white,
                                        initialDateTime:
                                            documentSnapshot['date_of_birth']
                                                .toDate(),
                                        onDateTimeChanged:
                                            (DateTime selectedTime) {
                                          setState(() {
                                            _currentDate = selectedTime;
                                          });
                                        },
                                        mode: CupertinoDatePickerMode.date,
                                      ),
                                    ));
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField<String>(
                          value: documentSnapshot['gender'].isNotEmpty
                              ? documentSnapshot['gender']
                              : null,
                          decoration: textInputDecoration.copyWith(
                              fillColor: Colors.grey[200],
                              label: const Text('Giới tính')),
                          items: genders.map((itemone) {
                            return DropdownMenuItem(
                              value: itemone,
                              child: Text(itemone),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              setState(() => _currentGender = val!),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue:
                              documentSnapshot['phone_number'].toString(),
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Số điện thoại',
                              fillColor: Colors.grey[200],
                              label: const Text('Số điện thoại')),
                          validator: (val) =>
                              val!.isEmpty ? 'Vui lòng điền thông tin' : null,
                          onChanged: (val) {
                            setState(() {
                              _currentPhone = int.parse(val);
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: documentSnapshot['email'],
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Email',
                              fillColor: Colors.grey[200],
                              label: const Text('Email')),
                          validator: (val) =>
                              val!.isEmpty ? 'Vui lòng điền thông tin' : null,
                          onChanged: (val) {
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: documentSnapshot['address'],
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Địa chỉ',
                            fillColor: Colors.grey[200],
                            label: const Text('Địa chỉ'),
                          ),
                          validator: (val) =>
                              val!.isEmpty ? 'Vui lòng điền thông tin' : null,
                          onChanged: (val) {
                            setState(() {
                              _currentAddress = val;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await userCollection
                                    .doc(documentSnapshot.id)
                                    .update({
                                  "name": _currentName,
                                  'gender': _currentGender,
                                  'phone_number': _currentPhone,
                                  'address': _currentAddress,
                                  'date_of_birth': _currentDate,
                                });
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text("Update"))
                      ],
                    ))
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productID) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Lưu ý"),
        content: const Text(
          "Bạn có chắc chắn muốn xóa người dùng này không?",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await userCollection.doc(productID).delete();
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

    // // for snackBar
    // ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("You have successfully deleted a itmes")));
  }

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Tên người dùng...',
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          ),
        ),
        Expanded(
          child: StreamBuilder(
              stream: userCollection.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  final List<DocumentSnapshot> users = streamSnapshot.data!.docs
                      .where((element) => element['name']
                          .toLowerCase()
                          .contains(_search.toLowerCase()))
                      .toList();
                  if (users.isEmpty) {
                    return const Center(
                      child: Text(
                        'Không tìm thấy dữ liệu:(',
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot = users[index];
                      return Card(
                        color: const Color.fromARGB(255, 88, 136, 190),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(documentSnapshot['avatar']),
                          ),
                          title: Text(
                            documentSnapshot['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            documentSnapshot['phone_number'].toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: SizedBox(
                            width: 145,
                            child: Row(
                              children: [
                                IconButton(
                                    color: Colors.black,
                                    onPressed: () =>
                                        {_update(documentSnapshot)},
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    color: Colors.black,
                                    onPressed: () => {
                                          _delete(documentSnapshot.id),
                                        },
                                    icon: const Icon(Icons.delete)),
                                IconButton(
                                    color: Colors.black,
                                    onPressed: () => {},
                                    icon: const Icon(Icons.search)),
                              ],
                            ),
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
    );
  }
}
