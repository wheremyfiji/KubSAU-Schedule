import 'package:flutter/material.dart';

import '../utils/extensions/buildcontext.dart';

class CustomInfoChip extends StatelessWidget {
  final String label;
  final bool elevation;

  const CustomInfoChip({
    super.key,
    required this.label,
    this.elevation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      color: context.colorScheme.inversePrimary,
      elevation: elevation ? 8 : 0.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
        child: Text(
          label,
          maxLines: 1,
          style: TextStyle(
            fontSize: 12,
            color: context.colorScheme.inverseSurface,
          ),
        ),
      ),
    );
  }
}
