import 'package:flutter/material.dart';
import 'package:loginapp/components.dart';

class CustomDividedBar extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final Axis direction;
  final double? size;
  final Color? color;
  const CustomDividedBar({
    super.key,
    this.margin,
    this.direction = Axis.horizontal,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: direction == Axis.vertical ? defaultPadding / 16 : size,
      height: direction == Axis.horizontal ? defaultPadding / 16 : size,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(defaultPadding / 2),
      ),
    );
  }
}
