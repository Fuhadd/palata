import 'package:flutter/material.dart';
import 'package:untitled8/services/base_view.dart';
import 'package:untitled8/widgets/text_widget.dart';

// class CustomButton extends StatelessWidget {
//   final void Function()? onTap;
//   final String btnTitle;
//   final bool isLoading;
//
//   const CustomButton({
//     Key? key,
//     required this.onTap,
//     required this.btnTitle,
//     required this.isLoading,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BaseView<CustomButtonWidgetModel>(
//       builder: (context, model, child) => Container(
//         width: MediaQuery.of(context).size.width,
//         child: RawMaterialButton(
//           shape: RoundedRectangleBorder(
//             side: BorderSide(
//               color: KPrimaryGreen,
//               style: BorderStyle.solid,
//             ),
//             borderRadius: BorderRadius.all(
//               Radius.circular(
//                 SizeConfig.blockSizeHorizontal! * 2,
//               ),
//             ),
//           ),
//           padding: EdgeInsets.symmetric(
//             vertical: SizeConfig.blockSizeVertical! * 3,
//           ),
//           textStyle: TextStyle(
//             color: model.isHighlighted ? KColorButtonText : KPrimaryGreen,
//             fontSize: 12,
//             fontWeight: FontWeight.w700,
//           ),
//           onPressed: onTap!,
//           onHighlightChanged: model.toggleTextColor,
//           splashColor: KPrimaryGreen,
//           child: isLoading
//               ? Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: (SizeConfig.blockSizeVertical! -
//                               SizeConfig.blockSizeHorizontal!) *
//                           5,
//                       height: (SizeConfig.blockSizeVertical! -
//                               SizeConfig.blockSizeHorizontal!) *
//                           5,
//                       child: CircularProgressIndicator(
//                         backgroundColor: KPrimaryGreen,
//                         strokeWidth: 2,
//                         valueColor: AlwaysStoppedAnimation(
//                           KWhiteColor,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: SizeConfig.blockSizeHorizontal! * 3,
//                     ),
//                     Text(
//                       'Loading...',
//                       style: TextStyle(
//                         color: KPrimaryGreen,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 )
//               : Text(
//                   btnTitle,
//                 ),
//         ),
//       ),
//     );
//   }
// }

class GestureButtonWidget extends StatefulWidget {
  final double circularSize;
  final Color? buttonColor;
  final Color? textColor;
  final String? text;
  final double? height;
  final double? width;
  final VoidCallback? onPress;
  final double? size;

  const GestureButtonWidget(
      {this.buttonColor,
      this.text,
      this.onPress,
      this.textColor,
      this.width,
      this.height,
      this.size,
      required this.circularSize});

  @override
  _GestureButtonWidgetState createState() => _GestureButtonWidgetState();
}

class _GestureButtonWidgetState extends State<GestureButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Container(
            height: widget.height,
            width: widget.width,
            padding: const EdgeInsets.symmetric(horizontal: 60),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.circularSize)),
                color: widget.buttonColor),
            child: TextButton(
              onPressed: widget.onPress,
              child: TextWidget(
                textSize: widget.size ?? 18,
                fontWeight: FontWeight.w700,
                text: widget.text,
                color: widget.textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
// declaring variables
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;
  final double? size;

//Constructor
  const MyButton(
      {this.color,
      this.textColor,
      required this.buttonText,
      this.buttontapped,
      this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(25),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: size ?? 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
