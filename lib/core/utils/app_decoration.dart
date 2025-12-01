import 'package:flutter/material.dart';

abstract class AppDecoration {
  static var greyBoxDecoration = ShapeDecoration(
    color: const Color(0x7ff2f3f3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );
}
