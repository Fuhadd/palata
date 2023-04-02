import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/text_widget.dart';

class MessageScreen extends StatelessWidget {
  Timestamp? date;
  String? message;
  MessageScreen({Key? key, this.date, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(false),
          )),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Center(
                child: Row(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.asset('assets/Palata.png'),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Palata',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          buildText(
                              DateFormat.yMMMMd('en_US').format(date!.toDate()),
                              Colors.black,
                              14,
                              0),
                          buildText(DateFormat.jm().format(date!.toDate()),
                              Colors.black, 14, 0)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(height: 15),
              buildText(message!, Colors.black, 16, 0)
            ],
          ),
        ),
      ),
    );
  }
}
