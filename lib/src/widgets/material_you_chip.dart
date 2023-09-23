import 'package:flutter/material.dart';

import '../utils/extensions/buildcontext.dart';

class MaterialYouChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onPressed;

  const MaterialYouChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorPrimary = selected
        ? context.theme.colorScheme.secondaryContainer
        : Colors.transparent;

    final colorOnPrimary = selected
        ? context.theme.colorScheme.onSecondaryContainer
        : context.colorScheme.onBackground;

    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          style: selected ? BorderStyle.none : BorderStyle.solid,
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      color: colorPrimary,
      shadowColor: Colors.transparent,
      elevation: selected ? 1 : 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: selected ? null : onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // if (selected)
              //   Padding(
              //     padding: const EdgeInsets.only(right: 8),
              //     child: Icon(
              //       Icons.check,
              //       size: 16,
              //       color: colorOnPrimary,
              //     ),
              //   ),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: colorOnPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
