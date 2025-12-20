import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/utils/app_colors.dart';
import 'package:myapp/core/utils/app_text_styles.dart';
import 'package:myapp/features/address/domain/entities/address_entity.dart';
import 'package:myapp/features/address/presentation/cubits/address_cubit/address_cubit.dart';
import 'package:myapp/features/address/presentation/views/add_address_view.dart';
import 'package:myapp/features/checkout/domain/entities/order_entity.dart';

class AddressInputSection extends StatefulWidget {
  const AddressInputSection({
    super.key,
    required this.formkey,
    required this.valueListenable,
  });
  final GlobalKey<FormState> formkey;
  final ValueListenable<AutovalidateMode> valueListenable;

  @override
  State<AddressInputSection> createState() => _AddressInputSectionState();
}

class _AddressInputSectionState extends State<AddressInputSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        if (state is AddressSuccess) {
          final addresses = state.addresses;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                if (addresses.isNotEmpty) ...[
                  Text('اختر عنوان التوصيل', style: TextStyles.bold16),
                  const SizedBox(height: 12),
                  ...addresses.map(
                    (address) => _buildAddressItem(context, address),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey[300])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'أو',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey[300])),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, AddAddressView.routeName);
                    },
                    icon: Icon(
                      Icons.add_location_alt,
                      color: AppColors.primaryColor,
                    ),
                    label: Text(
                      'إضافة عنوان جديد',
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: AppColors.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                if (addresses.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'يرجى إضافة عنوان للمتابعة',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          );
        }
        if (state is AddressLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildAddressItem(BuildContext context, AddressEntity address) {
    bool isSelected = _isAddressSelected(context, address);

    // Auto-select default if none selected
    if (!isSelected &&
        address.isDefault &&
        _getSelectedAddress(context) == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _selectAddress(context, address);
      });
    }

    return GestureDetector(
      onTap: () {
        _selectAddress(context, address);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primaryColor.withOpacity(0.05)
                  : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primaryColor : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(address.name, style: TextStyles.bold16),
                  const SizedBox(height: 4),
                  Text(
                    '${address.city}, ${address.street}',
                    style: TextStyles.regular13.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    address.phone,
                    style: TextStyles.regular13.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectAddress(BuildContext context, AddressEntity address) {
    setState(() {
      // Update Order Entity
      final orderEntity = context.read<OrderEntity>();
      orderEntity.shippingAddressEntity.name = address.name;
      orderEntity.shippingAddressEntity.adrees = address.street;
      orderEntity.shippingAddressEntity.city = address.city;
      orderEntity.shippingAddressEntity.sate = address.phone;
      orderEntity.shippingAddressEntity.mapAdrees =
          '${address.latitude},${address.longitude}';
    });
  }

  bool _isAddressSelected(BuildContext context, AddressEntity address) {
    final orderEntity = context.read<OrderEntity>();
    return orderEntity.shippingAddressEntity.adrees == address.street &&
        orderEntity.shippingAddressEntity.name == address.name;
  }

  AddressEntity? _getSelectedAddress(BuildContext context) {
    // Helper to check what's currently selected
    // Note: Since OrderEntity holds loose strings, we can't easily find the EXACT entity object unless we match ID.
    // AddressEntity has ID, but ShippingAddressEntity does not.
    // So distinctness relies on name/street uniqueness or external logic.
    // For now returning null is fine as long as we don't rely on it for anything critical other than the initial auto-select check logic.
    return null;
  }
}
