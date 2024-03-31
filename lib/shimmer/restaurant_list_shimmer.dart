import 'package:flutter/material.dart';
import 'package:quick_eats/shimmer/shimmer_widget.dart';
import 'package:quick_eats/utils/utils.dart';

class RestaurantShimmerList extends StatelessWidget {
  const RestaurantShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerWidget.rectangular(height: 150, borderRadius: 5),
            kYGap(5),
            ShimmerWidget.rectangular(
                height: 20, width: kScreenX(context) * .4),
            kYGap(5),
            const ShimmerWidget.rectangular(height: 8),
            kYGap(5),
            ShimmerWidget.rectangular(height: 8, width: kScreenX(context) * .6),
            kYGap(5),
            const ShimmerWidget.rectangular(height: 24, width: 24),
            kYGap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShimmerWidget.rectangular(
                    height: 20, width: kScreenX(context) * .3),
                ShimmerWidget.rectangular(
                    height: 20, width: kScreenX(context) * .2),
              ],
            ),
            kYGap(30),
          ],
        );
      },
    );
  }
}
