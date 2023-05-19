import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/hoan_tat_dat_lich_screen.dart';

class DatLichDetailsScreen extends StatefulWidget {
  const DatLichDetailsScreen({super.key});

  @override
  State<DatLichDetailsScreen> createState() => _DatLichDetailsState();
}

class _DatLichDetailsState extends State<DatLichDetailsScreen> {
  bool morning1 = true;
  bool morning2 = true;
  bool morning3 = true;
  bool morning4 = true;
  bool afternoon1 = true;
  bool afternoon2 = true;
  bool afternoon3 = true;
  bool evening1 = true;
  bool evening2 = true;
  bool evening3 = true;

  DateTime _selectedDate = DateTime.now();

  void _presentDataPicker() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Ngày khám: ${DateFormat.yMd().format(_selectedDate)}',
              style: TextStyle(fontSize: 27),
            ),
            TextButton(
                onPressed: _presentDataPicker,
                child: const Text(
                  'Chọn ngày khám',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.purple),
                )),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Buổi sáng:',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      backgroundColor: morning1 ? Colors.white : Colors.purple),
                  onPressed: () => setState(() => morning1 = !morning1),
                  child: Text(
                    '6:00',
                    style: TextStyle(
                        fontSize: 30,
                        color: morning1 ? Colors.purple : Colors.white),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      backgroundColor: morning2 ? Colors.white : Colors.purple),
                  onPressed: () => setState(() => morning2 = !morning2),
                  child: Text(
                    '7:30',
                    style: TextStyle(
                        fontSize: 30,
                        color: morning2 ? Colors.purple : Colors.white),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      backgroundColor: morning3 ? Colors.white : Colors.purple),
                  onPressed: () => setState(() => morning3 = !morning3),
                  child: Text(
                    '9:00',
                    style: TextStyle(
                        fontSize: 30,
                        color: morning3 ? Colors.purple : Colors.white),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      backgroundColor: morning4 ? Colors.white : Colors.purple),
                  onPressed: () => setState(() => morning4 = !morning4),
                  child: Text(
                    '10:30',
                    style: TextStyle(
                        fontSize: 30,
                        color: morning4 ? Colors.purple : Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Buổi chiều:',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                const SizedBox(
                  height: 30,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      backgroundColor:
                          afternoon1 ? Colors.white : Colors.purple),
                  onPressed: () => setState(() => afternoon1 = !afternoon1),
                  child: Text(
                    '14:00',
                    style: TextStyle(
                        fontSize: 30,
                        color: afternoon1 ? Colors.purple : Colors.white),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      backgroundColor:
                          afternoon2 ? Colors.white : Colors.purple),
                  onPressed: () => setState(() => afternoon2 = !afternoon2),
                  child: Text(
                    '15:30',
                    style: TextStyle(
                        fontSize: 30,
                        color: afternoon2 ? Colors.purple : Colors.white),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      backgroundColor:
                          afternoon3 ? Colors.white : Colors.purple),
                  onPressed: () => setState(() => afternoon3 = !afternoon3),
                  child: Text(
                    '17:00',
                    style: TextStyle(
                        fontSize: 30,
                        color: afternoon3 ? Colors.purple : Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Buổi tối:',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                const SizedBox(
                  height: 30,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      backgroundColor: evening1 ? Colors.white : Colors.purple),
                  onPressed: () => setState(() => evening1 = !evening1),
                  child: Text(
                    '18:00',
                    style: TextStyle(
                        fontSize: 30,
                        color: evening1 ? Colors.purple : Colors.white),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      backgroundColor: evening2 ? Colors.white : Colors.purple),
                  onPressed: () => setState(() => evening2 = !evening2),
                  child: Text(
                    '19:30',
                    style: TextStyle(
                        fontSize: 30,
                        color: evening2 ? Colors.purple : Colors.white),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      backgroundColor: evening3 ? Colors.white : Colors.purple),
                  onPressed: () => setState(() => evening3 = !evening3),
                  child: Text(
                    '21:00',
                    style: TextStyle(
                        fontSize: 30,
                        color: evening3 ? Colors.purple : Colors.white),
                  ),
                ),
              ],
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
                        side: BorderSide(color: Colors.purple),
                        backgroundColor: Colors.purple,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HoanTatDatLichScreen()));
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
