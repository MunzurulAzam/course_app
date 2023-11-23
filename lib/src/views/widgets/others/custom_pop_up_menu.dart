import 'package:flutter/material.dart';
import 'package:loginapp/components.dart';

class CustomPopUpMenuWidget<T> extends StatelessWidget {
  const CustomPopUpMenuWidget({super.key, required this.headWidget, required this.items, required this.itemBuilder, this.onSelected, this.enabled = true});
  final Widget headWidget;
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final void Function(T item)? onSelected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      enabled: enabled,
      icon: headWidget,
      clipBehavior: Clip.antiAlias,
      onSelected: onSelected,
      position: PopupMenuPosition.under,
      elevation: defaultPadding / 8,
      constraints: BoxConstraints(minWidth: defaultBoxHeight * 3),
      enableFeedback: false,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      itemBuilder: (BuildContext context) {
        return items
            .map(
              (e) => PopupMenuItem<T>(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                height: 0,
                value: e,
                child: itemBuilder(e),
              ),
            )
            .toList();
      },
    );
  }
}
