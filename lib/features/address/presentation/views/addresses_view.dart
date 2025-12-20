import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/utils/app_colors.dart';
import 'package:myapp/core/utils/app_text_styles.dart';
import 'package:myapp/features/address/presentation/cubits/address_cubit/address_cubit.dart';
import 'package:myapp/features/address/domain/entities/address_entity.dart';
import 'package:myapp/features/address/presentation/views/add_address_view.dart';

class AddressesView extends StatelessWidget {
  static const String routeName = 'AddressesView';
  const AddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عناويني'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddAddressView.routeName);
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          if (state is AddressLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AddressSuccess) {
            if (state.addresses.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_off,
                      size: 80,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text('لا توجد عناوين محفوظة', style: TextStyles.bold16),
                  ],
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.addresses.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final address = state.addresses[index];
                return _buildAddressItem(context, address);
              },
            );
          } else if (state is AddressFailure) {
            return Center(child: Text(state.errMessage));
          }
          return const SizedBox();
        },
      ),
    );
  }

Widget _buildAddressItem(BuildContext context, AddressEntity address) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isSmallScreen = screenWidth < 360;
  
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: address.isDefault
          ? Border.all(color: AppColors.primaryColor, width: 2)
          : Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.location_on,
                color: AppColors.primaryColor,
                size: isSmallScreen ? 18 : 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                address.name,
                style: TextStyles.bold16.copyWith(
                  fontSize: isSmallScreen ? 14 : 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (address.isDefault) ...[
              const SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 6 : 8,
                  vertical: isSmallScreen ? 3 : 4,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor,
                      AppColors.primaryColor.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'افتراضي',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 10 : 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Address Details
        _buildDetailRow(
          Icons.location_city_rounded,
          '${address.city}, ${address.street}',
          isSmallScreen,
        ),
        
        const SizedBox(height: 8),
        
        _buildDetailRow(
          Icons.phone_rounded,
          address.phone,
          isSmallScreen,
        ),
        
        const SizedBox(height: 16),
        
        // Divider
        Divider(color: Colors.grey.shade200, height: 1),
        
        const SizedBox(height: 8),
        
        // Action Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (!address.isDefault)
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    context.read<AddressCubit>().setDefaultAddress(address.id);
                  },
                  icon: Icon(
                    Icons.check_circle_outline,
                    size: isSmallScreen ? 16 : 18,
                  ),
                  label: Text(
                    'تعيين كافتراضي',
                    style: TextStyle(fontSize: isSmallScreen ? 12 : 13),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 8 : 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            if (!address.isDefault) const SizedBox(width: 4),
            
            // Edit Button
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AddAddressView.routeName,
                    arguments: address,
                  );
                },
                icon: Icon(
                  Icons.edit_rounded,
                  color: AppColors.primaryColor,
                  size: isSmallScreen ? 18 : 20,
                ),
                padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                constraints: const BoxConstraints(),
              ),
            ),
            
            const SizedBox(width: 8),
            
            // Delete Button
            Container(
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  _showDeleteConfirmDialog(context, address);
                },
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red,
                  size: isSmallScreen ? 18 : 20,
                ),
                padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                constraints: const BoxConstraints(),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildDetailRow(IconData icon, String text, bool isSmallScreen) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(
        icon,
        size: isSmallScreen ? 14 : 16,
        color: Colors.grey[600],
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          text,
          style: TextStyles.regular13.copyWith(
            color: Colors.grey[700],
            fontSize: isSmallScreen ? 12 : 13,
            height: 1.4,
          ),
        ),
      ),
    ],
  );
}
  void _showDeleteConfirmDialog(BuildContext context, AddressEntity address) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('حذف العنوان'),
            content: const Text('هل أنت متأكد من حذف هذا العنوان؟'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إلغاء'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<AddressCubit>().deleteAddress(address.id);
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('حذف'),
              ),
            ],
          ),
    );
  }
}
