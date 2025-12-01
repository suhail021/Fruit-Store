import 'package:flutter/material.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/core/helper_functions/build_error_bar.dart';
import 'package:myapp/core/widgets/custom_button.dart';
import 'package:myapp/features/checkout/domain/entities/order_entity.dart';
import 'package:myapp/features/checkout/presentation/manager/add_order_cubit/add_order_cubit.dart';
import 'package:myapp/features/checkout/presentation/views/widgets/checkout_steps.dart';
import 'package:myapp/features/checkout/presentation/views/widgets/checkout_steps_page_view.dart';
import 'package:provider/provider.dart';

class CheckoutViewBody extends StatefulWidget {
  const CheckoutViewBody({super.key});

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  late PageController pageController;
  ValueNotifier<AutovalidateMode> valueNotifier = ValueNotifier(
    AutovalidateMode.disabled,
  );

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPageIndex = pageController.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    valueNotifier.dispose();
    super.dispose();
  }

  int currentPageIndex = 0;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
      child: Column(
        children: [
          SizedBox(height: 20),
          CheckoutSteps(
            currentPageIndex: currentPageIndex,
            pageController: pageController,
          ),

          Expanded(
            child: CheckoutStepsPageView(
              pageController: pageController,
              formkey: _formkey,
              valueListenable: valueNotifier,
            ),
          ),
          CustomButton(
            onPressed: () {
              if (currentPageIndex == 0) {
                _handelShippingSectionValidation();
              } else if (currentPageIndex == 1) {
                _handelAdressValidation(context);
              } else {
                var orderEntity = context.read<OrderEntity>();
                context.read<AddOrderCubit>().addOrder(order: orderEntity);
              }
            },
            text: getNextButtonText(currentPageIndex),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  dynamic _handelAdressValidation(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      pageController.animateToPage(
        currentPageIndex + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceIn,
      );
    } else {
      valueNotifier.value = AutovalidateMode.always;
    }
  }

  void _handelShippingSectionValidation() {
    if (context.read<OrderEntity>().payWithCash != null) {
      pageController.animateToPage(
        currentPageIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      showErrorBar(context, 'يرجى تحديد طريقة الدفع');
    }
  }

  String getNextButtonText(int currentPageIndex) {
    switch (currentPageIndex) {
      case 0:
        return 'التالي';
      case 1:
        return 'التالي';
      case 2:
        return 'تاكيد الطلب';
      default:
        return 'التالي';
    }
  }
}
