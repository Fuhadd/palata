import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled8/services/base_view.dart';
import 'package:untitled8/viewModels/home_view_model.dart';

import '../../constant/colors.dart';
import '../../routes/route.dart';
import '../../widgets/custom_bottom_nav.dart';
import 'home_screen.dart';

class ViewEstate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';

    return BaseView<HomeViewModel>(
      builder: (context, model, child) => Scaffold(
        bottomNavigationBar: const CustomBottomNav(),
        body: SafeArea(
            child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Material(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: TextField(
                        // controller: TextEditingController(text: locations[0]),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: const InputDecoration(
                            hintText: "Search",
                            hintStyle:
                                TextStyle(color: Colors.black38, fontSize: 16),
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: const [
                    // ChoiceChip(
                    //   label:  Text('Completed',
                    //       style: TextStyle(color: Colors.white)),
                    //   selectedColor: kMainColor,
                    //   onSelected: (val) {
                    //     model.selectedValue("Completed");
                    //   },
                    //   selected: true,
                    // ),
                    // ChoiceChip(
                    //   selectedColor: kMainColor,
                    //   label: const Text('Incomplete',
                    //       style: TextStyle(color: Colors.white)),
                    //   onSelected: (val) {
                    //     model.selectedValue("Incomplete");
                    //   },
                    //   selected: true,
                    // )
                  ],
                ),
                const SizedBox(height: 20),
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("estate")
                      .doc("collection")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    Map<String, dynamic> documentFields =
                        snapshot.data!.data() as Map<String, dynamic>;

                    if (documentFields['data'] == null) {
                      return const Text('No item now');
                    }

                    final List<Map<String, dynamic>> itemDetailList =
                        (documentFields['data'] as List)
                            .map((itemDetail) =>
                                itemDetail as Map<String, dynamic>)
                            .toList();

                    final data = model.value == null
                        ? itemDetailList
                        : itemDetailList
                            .where((el) => el.values.contains("Completed"))
                            .toList();

                    //if(itemDetailList.where(("type") => el.position.contains('Completed')).toList()))

                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (_, index) {
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  children: [
                                    Image.network(
                                      '${data[index]['images'][0]['image']}',
                                      height: 90,
                                      width: 90,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          buildText(
                                              text: data[index]['address'],
                                              color: Colors.black,
                                              fontSize: 17),
                                          const SizedBox(height: 10),
                                          buildText(
                                              text: "2 BD| 2BA | 1700 SQFT",
                                              color: Colors.black,
                                              fontSize: 15),
                                          const SizedBox(height: 10),
                                          Center(
                                            child: buildText1(
                                                text:
                                                    "₦${data[index]['purchasePrice'].toString().replaceAllMapped(reg, mathFunc)}",
                                                color: Colors.black,
                                                fontSize: 22),
                                          ),
                                          const SizedBox(height: 10),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              buildText(
                                                  text: 'AVAILABLE',
                                                  color: Colors.black,
                                                  fontSize: 15),
                                              buildText(
                                                  text:
                                                      '${data[index]['availablePercentage'].toString()}%',
                                                  color: Colors.black,
                                                  fontSize: 15),
                                              buildText1(
                                                  text:
                                                      '₦${data[index]['purchasePrice'].toString().replaceAllMapped(reg, mathFunc)}',
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // model.loading
                                  //     ? Container(
                                  //         height: 60,
                                  //         margin: const EdgeInsets.symmetric(
                                  //             horizontal: 60),
                                  //         child: ElevatedButton(
                                  //             style: ElevatedButton.styleFrom(
                                  //               primary: kMainColor,
                                  //               shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(0),
                                  //               ),
                                  //             ),
                                  //             onPressed: () {},
                                  //             child:
                                  //                 const CircularProgressIndicator(
                                  //               color: Colors.white,
                                  //             )),
                                  //       )
                                  // : GestureButtonWidget(
                                  //     width: 200,
                                  //     height: 50,
                                  //     circularSize: 0,
                                  //     buttonColor: kMainColor,
                                  //     text: 'INTEREST',
                                  //     textColor: Colors.white,
                                  //     onPress: () {
                                  //      ;
                                  //       model.updateMessage(context,message:  model.messages =
                                  //       'Thank you for indicating your interest in ${data[index]['address']}');
                                  //       model.updateInterest(
                                  //           email: model.databaseInfo
                                  //               .userDetails.email,
                                  //           address: data[index]
                                  //               ['address']);
                                  //     }),

                                  // ),
                                  // GestureButtonWidget(
                                  //     circularSize: 0,
                                  //     buttonColor: kMainColor,
                                  //     text: 'VIEW',
                                  //     textColor: Colors.white,
                                  //     onPress: () {
                                  //       model.selection(
                                  //           sAddress: data[index]['address'],
                                  //           sOwnedPercentage: data[index]
                                  //               ['availablePercentage'],
                                  //           sTotalReturn: data[index]
                                  //                   ['purchasePrice']
                                  //               .toString(),
                                  //           sMonthlyReturn: data[index]
                                  //               ['monthlyReturn'],
                                  //           sPropertyPercentage: data[index]
                                  //               ['availablePercentage'],
                                  //           sPurchasedPrice: data[index]
                                  //               ['purchasePrice'],
                                  //           sPurchaseDate: data[index]
                                  //               ['purchaseDate'],
                                  //           sImage: data[index]['image'],
                                  //           sImages: data[index]['images']);
                                  //       model.purchaseType = "Buy";
                                  //       model.propertyType =
                                  //           data[index]['type'];
                                  //       Navigator.pushNamed(
                                  //           context, Routes.ESTATE_VIEW);
                                  //     }),
                                  InkWell(
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 10),
                                        color: kMainColor,
                                        child: const Text(
                                          'VIEW',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      model.selection(
                                          sAddress: data[index]['address'],
                                          sOwnedPercentage: data[index]
                                              ['availablePercentage'],
                                          sTotalReturn: data[index]
                                                  ['purchasePrice']
                                              .toString(),
                                          sMonthlyReturn: data[index]
                                              ['monthlyReturn'],
                                          sPropertyPercentage: data[index]
                                              ['availablePercentage'],
                                          sPurchasedPrice: data[index]
                                              ['purchasePrice'],
                                          sPurchaseDate: data[index]
                                              ['purchaseDate'],
                                          sImage: data[index]['image'],
                                          sImages: data[index]['images']);
                                      model.purchaseType = "Buy";
                                      model.propertyType = data[index]['type'];
                                      Navigator.pushNamed(
                                          context, Routes.ESTATE_VIEW);
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (BuildContext context) =>
                                      //             PercentageView(
                                      //               type: 'Buy',
                                      //               price: data[index]
                                      //                   ['purchasePrice'],
                                      //               percentage:
                                      //               data[index]
                                      //                       ['availablePercentage'],
                                      //               address: data[index]
                                      //                   ['address'],
                                      //             )));
                                    },
                                  ),
                                ],
                              ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 0),
                              //   child: GestureButtonWidget(
                              //       circularSize: 0,
                              //       buttonColor: kMainColor,
                              //       text: 'BUY',
                              //       textColor: Colors.white,
                              //       onPress: () {
                              //         model.selection(
                              //             sAddress: itemDetailList[index]
                              //                 ['address'],
                              //             sPercentage: itemDetailList[index]
                              //                 ['percentage'],
                              //             sTotalReturn: itemDetailList[index]
                              //                     ['purchasePrice']
                              //                 .toString(),
                              //             sMonthlyReturn: itemDetailList[index]
                              //                 ['monthlyReturn'],
                              //             sPercentageReturn:
                              //                 itemDetailList[index]
                              //                     ['percentageReturn'],
                              //             sPurchasedPrice: itemDetailList[index]
                              //                     ['purchasePrice']
                              //                 .toString(),
                              //             sPurchaseDate: itemDetailList[index]
                              //                 ['purchaseDate'],
                              //             sImage: itemDetailList[index]
                              //                 ['image'],
                              //             sImages: itemDetailList[index]
                              //                 ['images']);
                              //         Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //                 builder: (BuildContext context) =>
                              //                     PercentageView(
                              //                       price: itemDetailList[index]
                              //                               ['purchasePrice']
                              //                           .toString(),
                              //                       percentage:
                              //                           itemDetailList[index]
                              //                               ['percentage'],
                              //                       address:
                              //                           itemDetailList[index]
                              //                               ['address'],
                              //                     )));
                              //       }),
                              // ),
                              const Divider(color: Colors.grey),
                            ],
                          );
                        });
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
