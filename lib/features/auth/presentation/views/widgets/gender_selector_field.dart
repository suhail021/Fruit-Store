import 'package:flutter/material.dart';
import 'package:myapp/core/utils/app_text_styles.dart';

class GenderSelectorField extends StatefulWidget {
  final String? initialValue;
  final Function(String?)? onChanged;
  final FormFieldValidator<String>? validator;

  const GenderSelectorField({
    Key? key,
    this.initialValue,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  _GenderSelectorFieldState createState() => _GenderSelectorFieldState();
}

class _GenderSelectorFieldState extends State<GenderSelectorField> {
  String? selectedGender;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.initialValue;
  }

  void _onChanged(String? value) {
    setState(() {
      selectedGender = value;
      _showError = false;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator:
          widget.validator ??
          (value) {
            if (selectedGender == null) {
              setState(() {
                _showError = true;
              });
              return "";
            }
            return null;
          },
      builder: (FormFieldState<String> field) {
        return Container(
          decoration: BoxDecoration(
          color: Color(0xfff9fafa),
          shape: BoxShape.rectangle,
           border: Border.all(color:Color(0xffe6e9e9)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 12.0, top: 8.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "الجنس:",
                  style: TextStyles.bold19,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Radio<String>(
                      value: "ذكر",
                      groupValue: selectedGender,
                      onChanged: _onChanged,
                    ),
                    const Text("ذكر"),
                    const SizedBox(width: 20),
                    Radio<String>(
                      value: "أنثى",
                      groupValue: selectedGender,
                      onChanged: _onChanged,
                    ),
                    const Text("أنثى"),
                  ],
                ),
                if (_showError)
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "يرجى اختيار الجنس",
                      style: TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
