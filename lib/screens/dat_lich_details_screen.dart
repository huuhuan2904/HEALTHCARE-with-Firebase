import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/models/doctor.dart';
import 'package:project/services/database.dart';
import 'package:provider/provider.dart';

import 'hoan_tat_dat_lich_screen.dart';

class DatLichDetailsScreen extends StatefulWidget {
  final String doctorId;
  final String userId;
  final String userName;
  final int userPhoneNum;
  final String userAddress;
  final String userAvatar;
  final String doctorName;
  final int doctorPhoneNum;
  final String doctorAddress;
  final String doctorAvatar;
  DatLichDetailsScreen(
      this.doctorId,
      this.userId,
      this.userName,
      this.userPhoneNum,
      this.userAddress,
      this.userAvatar,
      this.doctorName,
      this.doctorPhoneNum,
      this.doctorAddress,
      this.doctorAvatar);

  @override
  State<DatLichDetailsScreen> createState() => _DatLichDetailsState();
}

class _DatLichDetailsState extends State<DatLichDetailsScreen> {
  String? _currentAddress;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _hourAndMinute = '';
  bool appointmentStatus = false;
  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 7)))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _presentTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _selectedTime = value!;
        _hourAndMinute = '${_selectedTime.hour}:${_selectedTime.minute}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<MyDoctor>(context);
    _hourAndMinute = '${_selectedTime.hour}:${_selectedTime.minute}';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Thời gian khám'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ngày khám: ${DateFormat('MM/dd/yyyy').format(_selectedDate)}',
              style: const TextStyle(fontSize: 27),
            ),
            TextButton(
                onPressed: _presentDatePicker,
                child: const Text(
                  'Chọn ngày khám',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.purple),
                )),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Giờ khám: ${_selectedTime.format(context).toString()}',
              style: const TextStyle(fontSize: 27),
            ),
            TextButton(
                onPressed: _presentTimePicker,
                child: const Text(
                  'Chọn giờ khám',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.purple),
                )),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: widget.userAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Địa chỉ',
                hintText: 'Địa chỉ',
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
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 180,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.purple),
                        backgroundColor: Colors.purple,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    onPressed: () {
                      // LichKhamScreen(_selectedDate);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HoanTatDatLichScreen(
                              _selectedDate,
                              _selectedTime,
                              widget.userName,
                              widget.userPhoneNum,
                              _currentAddress ?? widget.userAddress,
                              widget.doctorName,
                              widget.doctorPhoneNum,
                              widget.doctorAddress,
                              widget.doctorAvatar)));
                      // DatabaseServiceDoctor(uid: doctor.uid)
                      //     .addDocsNestedCollections(
                      //         widget.doctorId,
                      //         widget.userId,
                      //         _selectedDate,
                      //         _hourAndMinute,
                      //         widget.userName,
                      //         widget.userPhoneNum,
                      //         _currentAddress ?? widget.userAddress,
                      //         widget.userAvatar);
                      final CollectionReference appointments =
                          FirebaseFirestore.instance.collection('Appointments');
                      appointments.doc().set({
                        'doctor_id': widget.doctorId,
                        'user_id': widget.userId,
                        'date': DateTime.now(),
                        'booking_date': _selectedDate,
                        'booking_time': _hourAndMinute,
                        'user_name': widget.userName,
                        'user_phone_num': widget.userPhoneNum,
                        'user_address': _currentAddress ?? widget.userAddress,
                        'user_avatar': widget.userAvatar,
                        'status': appointmentStatus,
                      });
                    },
                    child: const Text(
                      'Xác nhận',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
