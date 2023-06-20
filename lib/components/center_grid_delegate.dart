import 'package:flutter/rendering.dart';

class CenteredGridDelegate extends SliverGridDelegate {
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  CenteredGridDelegate({
    required this.crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
  });

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double usableCrossAxisExtent =
        constraints.crossAxisExtent - crossAxisSpacing * (crossAxisCount - 1);
    final double childCrossAxisExtent = usableCrossAxisExtent / crossAxisCount;

    return SliverGridRegularTileLayout(
      crossAxisCount: crossAxisCount,
      mainAxisStride: childCrossAxisExtent + mainAxisSpacing,
      crossAxisStride: childCrossAxisExtent + crossAxisSpacing,
      childMainAxisExtent: childCrossAxisExtent,
      childCrossAxisExtent: childCrossAxisExtent,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(covariant CenteredGridDelegate oldDelegate) {
    return crossAxisCount != oldDelegate.crossAxisCount ||
        mainAxisSpacing != oldDelegate.mainAxisSpacing ||
        crossAxisSpacing != oldDelegate.crossAxisSpacing;
  }
}
