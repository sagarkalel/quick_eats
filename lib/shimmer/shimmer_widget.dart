import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Color baseColor;
  final Color? highlightColor;
  final double? radius;
  final double? borderRadius;

  const ShimmerWidget.rectangular({
    Key? key,
    required this.height,
    this.width,
    this.baseColor = Colors.grey,
    this.highlightColor,
    this.borderRadius = 0,
  })  : radius = null,
        super(key: key);

  const ShimmerWidget.circular({
    Key? key,
    required this.radius,
    this.baseColor = Colors.grey,
    this.highlightColor,
  })  : height = null,
        width = null,
        borderRadius = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildShimmer();
  }

  Widget _buildShimmer() {
    if (radius == null) {
      return Shimmer.fromColors(
        baseColor: baseColor.withOpacity(0.6),
        highlightColor: highlightColor ?? Colors.white,
        child: Container(
          height: height,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius ?? 0)),
        ),
      );
    } else {
      return Shimmer.fromColors(
        baseColor: baseColor.withOpacity(0.7),
        highlightColor: highlightColor ?? Colors.grey.shade300,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: baseColor.withOpacity(0.5),
        ),
      );
    }
  }
}
