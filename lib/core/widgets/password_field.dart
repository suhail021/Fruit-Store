import 'package:flutter/material.dart';
import 'package:myapp/core/widgets/custome_text_form_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, this.onsaved});
  final void Function(String?)? onsaved;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomeTextFormField(
      onSaved: (value) {
        widget.onsaved!(value);
      },
      suffixIcon: GestureDetector(
        onTap: () { 
          obscureText = !obscureText;
          setState(() {
            
          });
        },
        child: obscureText ?  Icon(Icons.remove_red_eye, color: Color(0xffc9cecf)) : 
        Icon(Icons.visibility_off, color: Color(0xffc9cecf)) ,
      ),
      hintText: 'كلمة المرور',
      obscureText: obscureText,
      textInputType: TextInputType.visiblePassword,
    );
  }
}
