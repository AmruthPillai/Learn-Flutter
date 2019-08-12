import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/loading_spinner.dart';
import 'package:shop_app/widgets/main_drawer.dart';
import 'package:shop_app/widgets/order_item_card.dart';

class OrdersPage extends StatelessWidget {
  static const String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting)
            return LoadingSpinner();

          if (dataSnapshot.hasError) {
            return Center(
              child: Text('An Error has Occured!'),
            );
          } else {
            return Consumer<Orders>(
              builder: (ctx, ordersStore, child) => ListView.builder(
                itemCount: ordersStore.orders.length,
                itemBuilder: (ctx, idx) =>
                    OrderItemCard(ordersStore.orders[idx]),
              ),
            );
          }
        },
      ),
    );
  }
}
