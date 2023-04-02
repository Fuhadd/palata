import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/colors.dart';

Container buildText(String text, Color color, double textSize, double margin) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: margin),
    child: Text(
      text,
      style: TextStyle(color: color, fontSize: textSize),
    ),
  );
}

Container buildText11(
    String text, Color color, double textSize, double margin) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: margin),
    child: Text(
      text,
      style: GoogleFonts.roboto(
        // textStyle: Theme.of(context).textTheme.display1,
        fontSize: textSize,
        color: color,
        // fontWeight: FontWeight.w700,
        // fontStyle: FontStyle.italic,
      ),
    ),
  );
}

Container buildBoldText(
    String text, Color color, double textSize, double margin) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: margin),
    child: Text(
      text,
      style: TextStyle(
          color: color, fontSize: textSize, fontWeight: FontWeight.w600),
    ),
  );
}

class RowWidget extends StatelessWidget {
  final String? text1;
  final String? text2;

  const RowWidget({this.text1, this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildText(text1!, Colors.black, 16, 0),
          buildText(text2!, Colors.black, 16, 0)
        ],
      ),
    );
  }
}

class RowWidget1 extends StatelessWidget {
  final String? text1;
  final String? text2;

  const RowWidget1({this.text1, this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildText(text1!, Colors.black, 16, 0),
          buildText11(text2!, Colors.black, 16, 0)
        ],
      ),
    );
  }
}

class Row2Widget extends StatelessWidget {
  final String? text1;
  final String? text2;
  final VoidCallback? onPressed;

  const Row2Widget({this.text1, this.text2, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildText(text1!, Colors.black, 18, 0),
          const SizedBox(width: 30),
          InkWell(
            child: Text(
              text2!,
              style: const TextStyle(color: kMainColor, fontSize: 18),
            ),
            onTap: onPressed,
          ),
        ],
      ),
    );
  }
}

class Row2Widget1 extends StatelessWidget {
  final String? text1;
  final String? text2;
  final VoidCallback? onPressed;

  const Row2Widget1({this.text1, this.text2, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildText(text1!, Colors.black, 18, 0),
          const SizedBox(width: 30),
          InkWell(
            child: Text(
              text2!,
              style: GoogleFonts.roboto(
                // textStyle: Theme.of(context).textTheme.display1,
                fontSize: 18,
                color: kMainColor,
                // fontWeight: FontWeight.w700,
                // fontStyle: FontStyle.italic,
              ),
              // style: const TextStyle(color: kMainColor, fontSize: 18),
            ),
            onTap: onPressed,
          ),
        ],
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final double? textSize;
  final String? text;
  final Color? color;
  final FontWeight? fontWeight;

  const TextWidget(
      {@required this.textSize,
      @required this.text,
      @required this.color,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(text!,
        style: TextStyle(
            color: color,
            fontFamily: 'Montserrat',
            fontSize: textSize,
            fontWeight: fontWeight));
  }
}
