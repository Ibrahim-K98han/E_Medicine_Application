import 'package:e_medicine/theme.dart';
import 'package:flutter/material.dart';

import '../network/model/history_model.dart';

class CardHistory extends StatelessWidget {
  final HistoryOrderDetailModel? model;
  const CardHistory({
    super.key,
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'INV: ${model!.invoice!}',
              style: boldTextStyle.copyWith(fontSize: 16),
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
        Text(
          model!.orderAt!,
          style: regularTextStyle.copyWith(fontSize: 16),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          model!.status == '1'
              ? 'Order is being confirmed'
              : 'order successful',
          style: lightTextStyle,
        ),
        const Divider()
      ],
    );
  }
}
