import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled8/services/base_view.dart';
import 'package:untitled8/viewModels/home_view_model.dart';
import 'package:untitled8/views/bottomNavScreen/message_screen.dart';
import 'package:untitled8/widgets/custom_bottom_nav.dart';
import 'package:untitled8/widgets/text_widget.dart';
import 'package:intl/intl.dart';

class MessageView extends StatefulWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        onModelReady: (model) async {},
        builder: (context, model, child) => Scaffold(
            bottomNavigationBar: const CustomBottomNav(),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(model.databaseInfo.userDetails.uid)
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      Map<String, dynamic> documentFields =
                          snapshot.data!.data() as Map<String, dynamic>;
                      final List<Map<String, dynamic>> messageList =
                          (documentFields['Messages'] as List)
                              .map((itemDetail) =>
                                  itemDetail as Map<String, dynamic>)
                              .toList();

                      if (messageList.isEmpty ||
                          documentFields.containsKey("Messages") == false) {
                        return Center(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset('assets/Palata.png'),
                            ),
                            const Text(
                              'No Message',
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ));
                      }

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildText('Messages', Colors.black, 25, 0),
                            const SizedBox(height: 20),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: messageList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  // var date =
                                  //     DateTime.fromMicrosecondsSinceEpoch(
                                  //         messageList[index]['date'] );
                                  return InkWell(
                                      child: Column(
                                        children: [
                                          // Align(
                                          //   alignment: Alignment.topRight,
                                          //   child: Text(DateFormat.yMMMMd('en_US')
                                          //       .format(date)),
                                          // ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 60,
                                                  width: 60,
                                                  child: Image.asset(
                                                      'assets/Palata.png'),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      buildText('Palata',
                                                          Colors.black, 18, 0),
                                                      const SizedBox(
                                                          height: 10),
                                                      buildText(
                                                          messageList[index]
                                                              ['message'],
                                                          Colors.grey,
                                                          14,
                                                          0)
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MessageScreen(
                                                      date: messageList[index]
                                                          ['date'],
                                                      message:
                                                          messageList[index]
                                                              ['message'],
                                                    )));
                                      });
                                }),
                          ],
                        ),
                      );
                    }),
              ),
            ))));
  }
}
