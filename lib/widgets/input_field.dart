import 'package:flutter/material.dart';
import '../../constant/colors.dart';

// closeKeyboard() {
//   final context = Get.context!;
//   FocusScope.of(context).requestFocus(FocusNode());
// }

Widget inputField(
  String hintText, {
  String? label,
  int maxLines: 7,
  int minLines: 5,
  TextEditingController? controller,
  bool isMultiline: false,
  // bool isPassword: false,
  bool showPassword: true,
  TextInputAction? textInputAction: TextInputAction.next,
  TextInputType? keyboardType,
  Function(String)? onSubmitted,
  Function(String)? onChanged,
  Function()? toggleShowPassword,
}) {
  if (minLines > maxLines) {
    maxLines = minLines + 2;
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (label != null)
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 6),
        //   child: Text(label, style: const TextStyle(color: kTextColor)),
        // ),
        Container(
          color: Colors.white,
          child: TextField(
            onChanged: onChanged,
            controller: controller,
            obscureText: !showPassword,
            onSubmitted: onSubmitted,
            textInputAction: isMultiline ? null : textInputAction,
            keyboardType: isMultiline ? TextInputType.multiline : keyboardType,
            minLines: isMultiline ? minLines : null,
            maxLines: isMultiline
                ? maxLines
                : !showPassword
                    ? 1
                    : null,
            decoration: InputDecoration(
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.all(15),
              hintText: hintText,
              fillColor: Colors.grey[700],
              focusColor: Colors.grey[700],
              hoverColor: Colors.grey[700],
              border: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: BorderRadius.circular(15),
              ),
              suffixIcon: toggleShowPassword != null
                  ? InkWell(
                      onTap: toggleShowPassword,
                      child: Icon(
                        showPassword
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye_rounded,
                        color: Colors.grey,
                      ),
                    )
                  : null,
            ),
          ),
        ),
    ],
  );
}

Widget inputFormField(
  String hintText, {
  String? label,
  int maxLines: 7,
  int minLines: 5,
  TextEditingController? controller,
  bool isMultiline: false,
  // bool isPassword: false,
  bool showPassword: true,
  TextInputAction? textInputAction: TextInputAction.next,
  TextInputType? keyboardType,
  Function(String?)? onSaved,
  Function(String)? onChanged,
  Function()? toggleShowPassword,
}) {
  if (minLines > maxLines) {
    maxLines = minLines + 2;
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (label != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(label, style: const TextStyle(color: kTextColor)),
        ),
      Container(
        color: Colors.grey,
        child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          obscureText: !showPassword,
          onSaved: onSaved,
          textInputAction: isMultiline ? null : textInputAction,
          keyboardType: isMultiline ? TextInputType.multiline : keyboardType,
          minLines: isMultiline ? minLines : null,
          maxLines: isMultiline
              ? maxLines
              : !showPassword
                  ? 1
                  : null,
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: kTextColor),
            contentPadding: const EdgeInsets.all(15),
            hintText: hintText,
            fillColor: Colors.grey[700],
            focusColor: Colors.white,
            hoverColor: Colors.grey[700],
            border: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(5),
            ),
            suffixIcon: toggleShowPassword != null
                ? InkWell(
                    onTap: toggleShowPassword,
                    child: Icon(showPassword
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye_rounded),
                  )
                : null,
          ),
        ),
      ),
    ],
  );
}
