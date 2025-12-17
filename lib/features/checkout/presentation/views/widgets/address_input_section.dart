import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/widgets/custome_text_form_field.dart';
import 'package:myapp/features/checkout/domain/entities/order_entity.dart';

class AddressInputSection extends StatelessWidget {
  const AddressInputSection({
    super.key,
    required this.formkey,
    required this.valueListenable,
  });
  final GlobalKey<FormState> formkey;
  final ValueListenable<AutovalidateMode> valueListenable;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ValueListenableBuilder<AutovalidateMode>(
        valueListenable: valueListenable,
        builder:
            (context, value, child) => Form(
              key: formkey,
              autovalidateMode: value,
              child: Column(
                children: [
                  SizedBox(height: 24),
                  CustomeTextFormField(
                    onSaved: (value) {
                      context.read<OrderEntity>().shippingAddressEntity.name =
                          value!;
                    },
                    hintText: 'الاسم',
                    textInputType: TextInputType.text,
                  ),
                  CustomeTextFormField(
                    onSaved: (value) {
                      context.read<OrderEntity>().shippingAddressEntity.city =
                          value!;
                    },
                    hintText: 'المدينة',
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 16),
                  CustomeTextFormField(
                    onSaved: (value) {
                      context.read<OrderEntity>().shippingAddressEntity.adrees =
                          value!;
                    },
                    hintText: 'الشارع',
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 16),
                  CustomeTextFormField(
                    onSaved: (value) {
                      context.read<OrderEntity>().shippingAddressEntity.sate =
                          value!;
                    },
                    hintText: 'الحي',
                    textInputType: TextInputType.text,
                  ),
                  CustomeTextFormField(
                    onSaved: (value) {
                      context
                          .read<OrderEntity>()
                          .shippingAddressEntity
                          .mapAdrees = value!;
                    },
                    hintText: 'الموقع في الخريطة',
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
      ),
    );
  }
}
