import 'package:flutter/material.dart';

void customeSnakBar(context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
