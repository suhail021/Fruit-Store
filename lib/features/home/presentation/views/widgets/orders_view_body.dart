// lib/features/home/presentation/views/widgets/orders_view_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/core/cubits/orders_cubit/orders_cubit.dart';
import 'package:myapp/core/widgets/custom_app_bar.dart';
import 'package:myapp/features/home/presentation/views/widgets/order_item_widget.dart';

class OrdersViewBody extends StatefulWidget {
  const OrdersViewBody({super.key});

  @override
  State<OrdersViewBody> createState() => _OrdersViewBodyState();
}

class _OrdersViewBodyState extends State<OrdersViewBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
          child: buildAppBar(context, title: "الطلبات", showBackIcon: false),
        ),

        // Tabs
        TabBar(
          controller: _tabController,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).primaryColor,
          tabs: const [
            Tab(text: 'الكل'),
            Tab(text: 'في انتظار الدفع'),
            Tab(text: 'قيد المعالجة'),
            Tab(text: 'مكتمل'),
          ],
        ),

        // Orders List
        Expanded(
          child: BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              if (state is OrdersLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is OrdersError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<OrdersCubit>().fetchOrders();
                        },
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                );
              }

              if (state is OrdersLoaded) {
                if (state.orders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد طلبات بعد',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildOrdersList(state.orders), // All
                    _buildOrdersList(
                      state.orders
                          .where((o) => o.paymentStatus == 'payment')
                          .toList(),
                    ), // Payment
                    _buildOrdersList(
                      state.orders
                          .where(
                            (o) =>
                                o.paymentStatus == 'paymented' ||
                                o.paymentStatus == 'confirmed' ||
                                o.paymentStatus == 'ordered',
                          )
                          .toList(),
                    ), // Processing
                    _buildOrdersList(
                      state.orders
                          .where((o) => o.paymentStatus == 'done')
                          .toList(),
                    ), // Done
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersList(List orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'لا توجد طلبات في هذا القسم',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<OrdersCubit>().fetchOrders();
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderItemWidget(
            order: orders[index],
            onTap: () {
              // TODO: Navigate to order details
            },
          );
        },
      ),
    );
  }
}
