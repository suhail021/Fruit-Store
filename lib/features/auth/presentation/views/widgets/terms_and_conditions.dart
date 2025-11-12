import 'package:flutter/material.dart';
import 'package:google/constants.dart';
import 'package:google/core/utils/app_colors.dart';
import 'package:google/core/utils/app_text_styles.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key, required this.onChanged});

  final ValueChanged<bool> onChanged;
  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

bool isTermsAccepted = false;

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(14, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Checkbox(
            value: isTermsAccepted,
            onChanged: (value) {
              isTermsAccepted = value!;
              widget.onChanged(value);
              setState(() {});
            },
            side: BorderSide(color: Color(0xffc9cecf), width: 1.5),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Color(0xffc9cecf), width: 0.2),
              borderRadius: BorderRadius.circular(5),
            ),
          ),

          SizedBox(
            width:
                MediaQuery.sizeOf(context).width -
                (kHorizintalPadding * 2) -
                48,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'من خلال إنشاء حساب ، فإنك توافق على  ',
                    style: TextStyles.semibold13.copyWith(
                      color: Color(0xff949d9e),
                    ),
                  ),
                  TextSpan(
                    text: 'الشروط والأحكام الخاصة بنا',
                    style: TextStyles.semibold13.copyWith(
                      color: AppColors.lightPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
