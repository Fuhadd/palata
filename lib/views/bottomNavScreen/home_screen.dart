import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/colors.dart';
import 'package:untitled8/routes/route.dart';
import 'package:untitled8/services/base_view.dart';
import 'package:untitled8/viewModels/home_view_model.dart';
import 'package:untitled8/widgets/text_widget.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../locator.dart';
import '../../model/estate_model.dart';
import '../../services/estate_service.dart';
import '../../widgets/custom_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<EstateModel> estate = [];

  final EstateService _estateService = locator<EstateService>();

  @override
  Widget build(BuildContext context) {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    return BaseView<HomeViewModel>(
        onModelReady: (model) async {},
        builder: (context, model, child) => WillPopScope(
              onWillPop: () => model.onWillPop(context),
              child: Scaffold(
                  bottomNavigationBar: const CustomBottomNav(),
                  body: SafeArea(
                      child: SingleChildScrollView(
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildText(
                                    text: 'Investing',
                                    fontSize: 25,
                                    color: Colors.black),
                                StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(firebaseUser!.uid)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 40,
                                          child: CircleAvatar(
                                            radius: 28,
                                            child: ClipOval(
                                              child: Image.asset(
                                                  'assets/images/user1.jpg'),
                                            ),
                                          ),
                                        );
                                      } else {
                                        Map<String, dynamic> documentFields =
                                            snapshot.data!.data()
                                                as Map<String, dynamic>;
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            documentFields["profileImage"]
                                                    .toString()
                                                    .isNotEmpty
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 30,
                                                    child: CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        documentFields[
                                                            "profileImage"],
                                                      ),
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 30,
                                                    child: CircleAvatar(
                                                      radius: 30,
                                                      child: ClipOval(
                                                        child: Image.asset(
                                                            'assets/images/avatar.png'),
                                                      ),
                                                    ),
                                                  )
                                          ],
                                        );
                                      }
                                    }),
                                // CircleAvatar(
                                //   backgroundColor: Colors.white,
                                //   radius: 40,
                                //   child: CircleAvatar(
                                //     radius: 28,
                                //     child: ClipOval(
                                //       child: Image.asset(
                                //           'assets/images/avatar.png'),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            buildText1(
                                text:
                                    '₦${model.databaseInfo.userDetails.investmentAmount ?? '0'}'
                                        .replaceAllMapped(
                                            RegExp(
                                                r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                            (Match m) => "${m[1]},"),
                                fontSize: 25,
                                color: Colors.black),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset('assets/images/polygon.svg'),
                                const SizedBox(
                                  width: 5,
                                ),
                                buildText1(
                                    text: '₦114,00 (2.9%) Last Month',
                                    fontSize: 12,
                                    color: kMainColor),
                                const SizedBox(
                                  width: 10,
                                ),
                                buildText(
                                    text: 'Today',
                                    fontSize: 12,
                                    color: Colors.black),
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            AspectRatio(
                              aspectRatio: 1.70,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: LineChart(
                                  model.showAvg ? avgData() : mainData(),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildText(
                                    text: 'Live',
                                    color: kMainColor,
                                    fontSize: 12),
                                buildText(
                                    text: '1D',
                                    color: kMainColor,
                                    fontSize: 12),
                                buildText(
                                    text: '1W',
                                    color: kMainColor,
                                    fontSize: 12),
                                buildText(
                                    text: '1M',
                                    color: kMainColor,
                                    fontSize: 12),
                                buildText(
                                    text: '3M',
                                    color: kMainColor,
                                    fontSize: 12),
                                buildText(
                                    text: '1Y',
                                    color: kMainColor,
                                    fontSize: 12),
                                buildText(
                                    text: 'ALL',
                                    color: kMainColor,
                                    fontSize: 12)
                              ],
                            ),
                            const SizedBox(height: 20),
                            Card(
                              elevation: 2,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                height: 50,
                                child: RowWidget1(
                                  text1: 'Wallet',
                                  text2:
                                      '₦${model.databaseInfo.userDetails.userBalance ?? '₦0'}'
                                          .replaceAllMapped(
                                              RegExp(
                                                  r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                              (Match m) => "${m[1]},"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            buildText(
                                text: 'Portfolio',
                                fontSize: 22,
                                color: Colors.black),
                            const SizedBox(height: 12),
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
                                    snapshot.data!.data()
                                        as Map<String, dynamic>;

                                if (documentFields['data'] == []) {
                                  return const Text('No item now');
                                }

                                final List<Map<String, dynamic>>
                                    itemDetailList =
                                    (documentFields['data'] as List)
                                        .map((itemDetail) =>
                                            itemDetail as Map<String, dynamic>)
                                        .toList();

                                return model.databaseInfo.userDetails
                                                .ownedProperties ==
                                            null ||
                                        model.databaseInfo.userDetails
                                            .ownedProperties!.isEmpty
                                    ? Card(
                                        elevation: 2,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                const Text(
                                                  'Welcome',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      wordSpacing: 5),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  '${model.databaseInfo.userDetails.firstName} ${model.databaseInfo.userDetails.lastName}',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      wordSpacing: 5,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(height: 5),
                                                const Text(
                                                  'properties you own will appear here.Click on "Search to view properties you can buy ',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      wordSpacing: 5),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(firebaseUser.uid)
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<DocumentSnapshot>
                                                snapshot) {
                                          Map<String, dynamic> documentFields =
                                              snapshot.data!.data()
                                                  as Map<String, dynamic>;

                                          final List<Map<String, dynamic>>
                                              proportionList =
                                              (documentFields['ownedProperties']
                                                      as List)
                                                  .map((itemDetail) =>
                                                      itemDetail as Map<String,
                                                          dynamic>)
                                                  .toList();
                                          return documentFields[
                                                          'ownedProperties'] ==
                                                      [] ||
                                                  documentFields[
                                                          "ownedProperties"]
                                                      .toString()
                                                      .isEmpty
                                              ? Card(
                                                  elevation: 2,
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            'Welcome',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                wordSpacing: 5),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Text(
                                                            '${model.databaseInfo.userDetails.firstName} ${model.databaseInfo.userDetails.lastName}',
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                wordSpacing: 5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          const Text(
                                                            'properties you own will appear here.Click on "Search to view properties you can buy ',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                wordSpacing: 5),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      proportionList.length,
                                                  itemBuilder: (_, index) {
                                                    final userOwnedProperties =
                                                        itemDetailList
                                                            .where((properties) =>
                                                                properties[
                                                                    "address"] ==
                                                                proportionList[
                                                                        index]
                                                                    ['address'])
                                                            .toList();
                                                    //print('OWNED HOME $userOwnedProperties');
                                                    return Column(
                                                        children:
                                                            userOwnedProperties
                                                                .map((e) {
                                                      return Card(
                                                          elevation: 2,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                            child: Row(
                                                              children: [
                                                                GestureDetector(
                                                                  child: Image
                                                                      .network(
                                                                    '${e['images'][0]['image']}',
                                                                    height: 90,
                                                                    width: 90,
                                                                  ),
                                                                  onTap: () {
                                                                    model.selection(
                                                                        sAddress: e[
                                                                            'address'],
                                                                        sOwnedPercentage: proportionList[index]
                                                                            [
                                                                            'proportion'],
                                                                        sTotalReturn:
                                                                            e['purchasePrice']
                                                                                .toString(),
                                                                        sMonthlyReturn: e[
                                                                            'monthlyReturn'],
                                                                        sPropertyPercentage: e[
                                                                            'availablePercentage'],
                                                                        sPurchasedPrice: e[
                                                                            'purchasePrice'],
                                                                        sPurchaseDate: e[
                                                                            'purchaseDate'],
                                                                        sImage: e[
                                                                            'image'],
                                                                        sImages:
                                                                            e['images']);
                                                                    model.purchaseType =
                                                                        "Buy&Sell";
                                                                    model.propertyType =
                                                                        "Completed";

                                                                    print(
                                                                        'ADDRESSSSS ${itemDetailList[index]}');
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        Routes
                                                                            .ESTATE_VIEW);
                                                                  },
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    children: [
                                                                      buildText(
                                                                          text: e[
                                                                              'address'],
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              17),
                                                                      const SizedBox(
                                                                          height:
                                                                              20),
                                                                      SizedBox(
                                                                        height:
                                                                            60,
                                                                        child:
                                                                            AspectRatio(
                                                                          aspectRatio:
                                                                              1.70,
                                                                          child:
                                                                              LineChart(
                                                                            model.showAvg
                                                                                ? avgData()
                                                                                : mainData(),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              15),
                                                                      Row2Widget1(
                                                                        text1:
                                                                            '${proportionList[index]['proportion'].toString()}%',
                                                                        text2:
                                                                            "₦${e['purchasePrice'].toString()}",
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ));
                                                    }).toList());
                                                  });
                                        });
                              },
                            ),
                          ]),
                    ),
                  ))),
            ));
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xFFF4F4F4),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: false,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 10),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
              case 11:
                return 'DEC';
            }
            return '';
          },
          margin: 10,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 2:
                return '50';
              case 4:
                return '100';
              case 6:
                return '150';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
              top: BorderSide(width: 1, color: Color(0xFFF4F4F4)),
              bottom: BorderSide(width: 1, color: Color(0xFFF4F4F4)))),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(2.0, 3),
            const FlSpot(2.6, 2),
            const FlSpot(4.9, 5),
            const FlSpot(6.8, 3.1),
            const FlSpot(8, 4),
            const FlSpot(9.5, 3),
            const FlSpot(11, 4),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
          ],
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: false, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.3),
          ]),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: false,
        drawHorizontalLine: false,
        getDrawingVerticalLine: (value) {
          return FlLine(
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 10,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(0, 3.44),
            const FlSpot(2.6, 3.44),
            const FlSpot(4.9, 3.44),
            const FlSpot(6.8, 3.44),
            const FlSpot(8, 3.44),
            const FlSpot(9.5, 3.44),
            const FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            show: true,
          ),
        ),
      ],
    );
  }
}

Text buildText(
    {required String text, required Color color, required double fontSize}) {
  return Text(
    text,
    softWrap: true,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontSize: fontSize, color: color),
  );
}

Text buildText1(
    {required String text, required Color color, required double fontSize}) {
  return Text(
    text,
    softWrap: true,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.roboto(
      // textStyle: Theme.of(context).textTheme.display1,
      fontSize: fontSize,
      color: color,
      // fontWeight: FontWeight.w700,
      // fontStyle: FontStyle.italic,
    ),

    // TextStyle(fontSize: fontSize, color: color),
  );
}
