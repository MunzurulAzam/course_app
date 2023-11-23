import 'package:flutter/material.dart';
import 'package:loginapp/components.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon(this.icon, {super.key, this.size, this.color});
  final IconData? icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size ?? defaultPadding,
      color: color ?? Theme.of(context).colorScheme.onBackground,
    );
  }
}
