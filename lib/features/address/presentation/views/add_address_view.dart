import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/utils/app_colors.dart';
import 'package:myapp/features/address/presentation/cubits/address_cubit/address_cubit.dart';
import 'package:myapp/features/address/domain/entities/address_entity.dart';
import 'package:myapp/features/address/presentation/views/widgets/map_view.dart';
import 'package:uuid/uuid.dart';

class AddAddressView extends StatefulWidget {
  static const String routeName = 'AddAddressView';
  // Optional argument for editing
  final AddressEntity? addressToEdit;

  const AddAddressView({super.key, this.addressToEdit});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  double? _latitude;
  double? _longitude;

  bool get isEditing => widget.addressToEdit != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      final addr = widget.addressToEdit!;
      _nameController.text = addr.name;
      _streetController.text = addr.street;
      _cityController.text = addr.city;
      _phoneController.text = addr.phone;
      _latitude = addr.latitude;
      _longitude = addr.longitude;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'تعديل العنوان' : 'إضافة عنوان جديد'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'اسم العنوان (مثال: المنزل، العمل)',
                ),
                validator: (value) => value!.isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'رقم الهاتف'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'المدينة'),
                validator: (value) => value!.isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(
                  labelText: 'اسم الشارع / الحي',
                ),
                validator: (value) => value!.isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 24),

              // Map Selection Button
              OutlinedButton.icon(
                onPressed: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    MapView.routeName,
                  );
                  if (result != null && result is Map<String, double>) {
                    setState(() {
                      _latitude = result['lat'];
                      _longitude = result['lng'];
                    });
                  }
                },
                icon: Icon(Icons.map, color: AppColors.primaryColor),
                label: Text(
                  _latitude != null
                      ? 'تم تحديد الموقع'
                      : 'تحديد الموقع على الخريطة',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: AppColors.primaryColor),
                ),
              ),
              if (_latitude != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'الإحداثيات: ${_latitude!.toStringAsFixed(4)}, ${_longitude!.toStringAsFixed(4)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  isEditing ? 'تحديث العنوان' : 'حفظ العنوان',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_latitude == null || _longitude == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('يرجى تحديد الموقع على الخريطة')),
        );
        return;
      }

      final address = AddressEntity(
        id: isEditing ? widget.addressToEdit!.id : const Uuid().v4(),
        name: _nameController.text,
        street: _streetController.text,
        city: _cityController.text,
        phone: _phoneController.text,
        latitude: _latitude!,
        longitude: _longitude!,
        isDefault: isEditing ? widget.addressToEdit!.isDefault : false,
      );

      if (isEditing) {
        context.read<AddressCubit>().editAddress(address);
      } else {
        context.read<AddressCubit>().addAddress(address);
      }
      Navigator.pop(context);
    }
  }
}
