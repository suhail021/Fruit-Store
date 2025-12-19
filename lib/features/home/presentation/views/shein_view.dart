import 'package:flutter/material.dart';
import 'package:myapp/features/home/presentation/views/widgets/shein_view_body.dart';

class SheinView extends StatelessWidget {
  const SheinView({super.key});
  static const String routeName = 'shein_view';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as String?;
    return SheinViewBody(initialUrl: args);
  }
}
