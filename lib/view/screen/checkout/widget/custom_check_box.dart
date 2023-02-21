import 'package:flutter/material.dart';
import 'package:eamar_user_app/provider/order_provider.dart';
import 'package:eamar_user_app/utill/color_resources.dart';
import 'package:eamar_user_app/utill/custom_themes.dart';
import 'package:provider/provider.dart';

class CustomCheckBox extends StatelessWidget {
  final String title;
  final int index;
  CustomCheckBox({@required this.title, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, order, child) {
        return InkWell(
          onTap: () => order.setPaymentMethod(index),
          child: Row(children: [
            Checkbox(
              shape: CircleBorder(),
              value: order.paymentMethodIndex == index,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (bool isChecked) => order.setPaymentMethod(index),
            ),
            Expanded(
              child: Text(title, style: titilliumRegular.copyWith(
                color: order.paymentMethodIndex == index ? Theme.of(context).textTheme.bodyText1.color : ColorResources.getGainsBoro(context),
              )),
            ),
          ]),
        );
      },
    );
  }
}
