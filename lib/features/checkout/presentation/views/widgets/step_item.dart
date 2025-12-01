import 'package:flutter/material.dart';
import 'package:myapp/features/checkout/presentation/views/widgets/active_step_item.dart';
import 'package:myapp/features/checkout/presentation/views/widgets/in_active_step_item.dart';

class StepItem extends StatelessWidget {
  const StepItem({
    super.key,
    required this.text,
    required this.index,
    required this.isActive,
  });
  final String text;
  final int index;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: InActiveStepItem(text: text, index: index),
      secondChild: ActiveStepItem(text: text),
      crossFadeState:
          isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: Duration(microseconds: 300),
    );
  }
}
