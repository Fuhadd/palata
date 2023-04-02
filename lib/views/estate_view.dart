import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../constant/colors.dart';
import 'package:untitled8/services/base_view.dart';
import 'package:untitled8/viewModels/home_view_model.dart';
import 'package:untitled8/views/percentage_view.dart';
import 'package:untitled8/widgets/text_widget.dart';

class EstateView extends StatefulWidget {
  @override
  _EstateViewState createState() => _EstateViewState();
}

class _EstateViewState extends State<EstateView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(builder: (context, model, child) {
      double? bought = (model.purchasedPrice * model.ownedPercentage) / 100;
      RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
      mathFunc(Match match) => '${match[1]},';

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
                  margin: const EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: model.images!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: const EdgeInsets.only(right: 20),
                                child: CachedNetworkImage(
                                  height: 240,
                                  width: 320,
                                  imageUrl: '${model.images![index]['image']}',
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    highlightColor: Colors.white,
                                    baseColor: Colors.grey,
                                    child:
                                        const SizedBox(height: 240, width: 360),
                                    period: const Duration(milliseconds: 800),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              );
                            }),
                      ),
                      // Container(
                      //   margin: EdgeInsets.symmetric(horizontal: 33),
                      //   child: Image.network(model.image),
                      // ),
                      const SizedBox(height: 30),
                      Center(
                        child: model.purchaseType == "Buy"
                            ? buildText11(
                                "₦${model.purchasedPrice.toString().replaceAllMapped(reg, mathFunc)}",
                                kMainColor,
                                30,
                                0)
                            : buildText11(
                                "₦${bought.toInt().toString().replaceAllMapped(reg, mathFunc)}",
                                kMainColor,
                                30,
                                0),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 6,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildText(
                                        model.address, Colors.black, 16, 0),
                                    RowWidget1(
                                      text1: "2 BD| 2BA | 1700 SQFT",
                                      text2: '₦${model.totalReturn}'
                                          .replaceAllMapped(reg, mathFunc),
                                    ),
                                    RowWidget1(
                                      text1: "BOUGHT ON ${model.purchaseDate}",
                                      text2: '₦${model.purchasedPrice}'
                                          .replaceAllMapped(reg, mathFunc),
                                    ),
                                    //work on this percentage * property price
                                    RowWidget1(
                                      text1:
                                          "${model.ownedPercentage.toString()}%",
                                      text2:
                                          "₦${bought.toInt().toString().replaceAllMapped(reg, mathFunc)}",
                                    ),
                                    const SizedBox(height: 18),
                                    model.propertyType == "Completed"
                                        ? Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              children: [
                                                RowWidget1(
                                                  text1: "Months Return",
                                                  text2:
                                                      "₦${(bought * 0.01).toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}",
                                                ),
                                                const Divider(
                                                  color: Colors.grey,
                                                  thickness: 1,
                                                ),
                                                RowWidget1(
                                                  text1: "Total Return",
                                                  text2:
                                                      "${model.ownedPercentage.toString()}%",
                                                ),
                                                const SizedBox(height: 30),
                                              ],
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text('Months Return',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black)),
                                                const SizedBox(width: 10),
                                                Text(
                                                    "₦${(bought * 0.01).toStringAsFixed(2).replaceAllMapped(reg, mathFunc)}",
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black)),
                                                const SizedBox(height: 23),
                                                const Divider(
                                                  color: Colors.grey,
                                                  thickness: 1,
                                                ),
                                                // RowWidget(
                                                //   text1: "Total Return",
                                                //   text2:
                                                //       "${model.ownedPercentage.toString()} ",
                                                // ),
                                                const SizedBox(height: 30),
                                              ],
                                            ),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 23),
                                          model.propertyType == "Completed"
                                              ? Column(
                                                  children: [
                                                    const RowWidget(
                                                      text1: "Current Lease",
                                                      text2:
                                                          "01/01/22 - Present",
                                                    ),
                                                    RowWidget1(
                                                      text1: "Rent",
                                                      text2:
                                                          "₦${(model.purchasedPrice * 0.01).toInt().toString().replaceAllMapped(reg, mathFunc)}",
                                                    ),
                                                    const RowWidget1(
                                                      text1:
                                                          "Property Management",
                                                      text2: "₦150,000 / Month",
                                                    ),
                                                    const RowWidget1(
                                                      text1: "Balance",
                                                      text2:
                                                          "₦1,395,000 / Month",
                                                    ),
                                                    const RowWidget1(
                                                      text1: "10%",
                                                      text2: "₦139,500 / Month",
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    const RowWidget(
                                                      text1: "Estimated Time",
                                                      text2: "6 Months",
                                                    ),
                                                    RowWidget1(
                                                      text1: "Purchase Price",
                                                      text2:
                                                          "₦${(model.purchasedPrice).toInt()}",
                                                    ),
                                                    const RowWidget1(
                                                      text1: "Fixes",
                                                      text2: "₦15,000,000",
                                                    ),
                                                    RowWidget1(
                                                      text1: "Sale Price",
                                                      text2:
                                                          "₦${(model.purchasedPrice + (0.35 * model.purchasedPrice)).toInt()}",
                                                    ),
                                                  ],
                                                )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          child: Container(
                                            padding: const EdgeInsets.all(20),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            color: kMainColor,
                                            child: const Text(
                                              'Buy',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          onTap: () {
                                            print("SELL ONENEN}");
                                            print(model.purchasedPrice);
                                            print('address');
                                            print(model.address);
                                            print('percentage');
                                            print(
                                                "BUY ${model.propertyPercentage}");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PercentageView(
                                                          type: 'Buy',
                                                          address:
                                                              model.address,
                                                          percentage: model
                                                              .propertyPercentage,
                                                          price: model
                                                              .purchasedPrice,
                                                        )));
                                          },
                                        ),
                                        model.purchaseType == "Buy"
                                            ? InkWell(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  color: kMainColor,
                                                  child: const Text(
                                                    'Interest',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                onTap: () {
                                                  model.uid = model.databaseInfo
                                                      .userDetails.uid;
                                                  model.messages =
                                                      'Thank you for indicating your interest in ${model.address}';
                                                  model.updateMessage(
                                                    context,
                                                    model.databaseInfo
                                                        .userDetails.uid,
                                                    message:
                                                        'Thank you for indicating your interest in ${model.address}',
                                                  );
                                                  model.updateInterest(
                                                      uid: model.databaseInfo
                                                          .userDetails.uid,
                                                      email: model.databaseInfo
                                                          .userDetails.email,
                                                      address: model.address);
                                                },
                                              )
                                            : InkWell(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  color: kMainColor,
                                                  child: const Text(
                                                    'Sell',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PercentageView(
                                                                type: 'Sell',
                                                                address: model
                                                                    .address,
                                                                percentage: model
                                                                    .ownedPercentage,
                                                                price: model
                                                                    .purchasedPrice,
                                                              )));
                                                },
                                              )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ))));
    });
  }
}
