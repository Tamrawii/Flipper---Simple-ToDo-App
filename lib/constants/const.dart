import 'package:flutter/material.dart';

const primaryColor = Color(0xff6C63FF);
const secondaryColor = Color(0xff7370A1);
const greyColor = Color(0x24000000);
const whiteColor = Colors.white;
const darkColor = Color(0xff160040);
const darkPurple = Color(0xff4C0070);

List<Color> dummyColors = const [
  Color(0xffF9908A),
  Color(0xffF9C68A),
];

bodyText1(double size, FontWeight fontWeight, Color color) => TextStyle(
      fontFamily: 'NotoSansThaiLooped',
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    );
