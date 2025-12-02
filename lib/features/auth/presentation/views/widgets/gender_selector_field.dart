// lib/features/auth/presentation/views/widgets/gender_selector_field.dart
import 'package:flutter/material.dart';

class GenderSelectorField extends StatefulWidget {
  final Function(String)? onChanged;
  
  const GenderSelectorField({
    super.key,
    this.onChanged,
  });

  @override
  State<GenderSelectorField> createState() => _GenderSelectorFieldState();
}

class _GenderSelectorFieldState extends State<GenderSelectorField> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffe6e9ea)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.person_outline, color: Color(0xffc9cecf)),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: const Text(
                  'اختر الجنس',
                  style: TextStyle(
                    color: Color(0xff949d9e),
                    fontSize: 13,
                  ),
                ),
                value: selectedGender,
                items: const [
                  DropdownMenuItem(
                    value: 'male',
                    child: Text('ذكر'),
                  ),
                  DropdownMenuItem(
                    value: 'female',
                    child: Text('أنثى'),
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    selectedGender = value;
                  });
                  if (widget.onChanged != null && value != null) {
                    widget.onChanged!(value);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}