import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utilities/app_colors.dart';

class CardShimmer extends StatelessWidget {
  const CardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.white,
      highlightColor: AppColors.loading,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9, height: 110),
      ),
    );
  }
}
