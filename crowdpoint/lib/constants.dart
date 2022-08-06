import 'package:flutter/material.dart';

const kBgColor = Color(0xFFFAFAFA);
const kL1Color = Color(0xFFFFFFFF);
const kBlackColor = Color(0xFF262626);

var kBoxDecoration = BoxDecoration(
  border: Border.all(
    color: Colors.black12,
  ),
  color: kL1Color,
  borderRadius: BorderRadius.circular(6),
);

var kTileUserNameDecoration = BoxDecoration(
  border: Border(
    bottom: BorderSide(
      width: 0.1,
    ),
  ),
);
