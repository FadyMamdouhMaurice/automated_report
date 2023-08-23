import 'package:automated_report/shared/styles/colors.dart';
import 'package:flutter/material.dart';

Widget myButton({
  required String buttonText,
  required Function buttonFunction,
  double width = double.infinity,
  double height = 40,
  Color color = const Color.fromRGBO(226, 17, 23, 10),
  double radius = 0.0,
  bool isUpperCase = true,
}) =>
    Container(
      height: height,
      width: width,
      child: MaterialButton(
        onPressed: () {
          buttonFunction;
        },
        child: Text(
          isUpperCase ? buttonText.toUpperCase() : buttonText,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
    );

Widget myTextFormField({
  required TextEditingController controller,
  required String label,
  IconData? prefixIcon,
  IconData? suffixIcon,
  double borderSideWidth = 1,
  double borderSideCircular = 20,
  required TextInputType textInputType,
  bool isPassword = false,
  var suffixPressed, // var not function because of null safety;
}) =>
    TextFormField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: secondaryColorApp,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: primaryColorApp,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                  color: primaryColorApp,
                ),
                onPressed: suffixPressed,
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: primaryColorApp, width: borderSideWidth),
          borderRadius: BorderRadius.circular(borderSideCircular),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: primaryColorApp, width: borderSideWidth),
          borderRadius: BorderRadius.circular(borderSideCircular),
        ),
      ),
      keyboardType: textInputType,
    );

/*
TableRow myTableRow(String data) => TableRow(children: [
    myCell('data'),
    ]);
*/

Widget myCell(String data) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(data),
    );

Widget myParagraph({
  required List data,
  required int i,
  required double leftPadding,
  required double fontSize,
  required Color color,
  required FontWeight fontWeight,
}) => Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Text(
        '${data[i]}',
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
