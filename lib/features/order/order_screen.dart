import 'package:ecommerce/cubits/main_cubit/main_cubit.dart';
import 'package:ecommerce/features/order/components/order_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class OrderScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xFF121212),
          appBar: AppBar(
            backgroundColor: Color(0xFF121212),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {},
            ),
            title: Text(
              'Processing',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          body: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: MainCubit.get(context).orderModel?.data?.orders?.length,
            itemBuilder: (context, index) {
              return OrderCard(order: MainCubit.get(context).orderModel?.data?.orders?[index]);
            },
          ),
        );
      },
    );
  }
}


