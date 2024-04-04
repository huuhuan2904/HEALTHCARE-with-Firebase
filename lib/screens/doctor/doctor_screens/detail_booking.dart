import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Detail_booking extends StatefulWidget {
  final String userName;
  final int userNumber;
  final String userAddress;
  final DateTime bookingDate;
  final String bookingTime;
  final DateTime date;
  const Detail_booking(this.userName, this.userNumber, this.userAddress,
      this.bookingDate, this.bookingTime, this.date,
      {super.key});

  @override
  State<Detail_booking> createState() => _Detail_bookingState();
}

class _Detail_bookingState extends State<Detail_booking> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage("assets/images/ad_main.png"),
          ),
          SizedBox(
            width: double.infinity,
            child: Card(
              color: Colors.pink[300],
              child: Column(
                children: [
                  Text(
                    widget.userName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(widget.userNumber.toString()),
                  Text(widget.userAddress),
                  Text(
                      ' ${DateFormat('MM/dd/yyyy').format(widget.bookingDate)}'),
                  Text(widget.bookingTime),
                  Text(' ${DateFormat('MM/dd/yyyy').format(widget.date)}'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
