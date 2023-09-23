import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../utils/extensions/buildcontext.dart';

const errorFaces = [
  'Σ(ಠ_ಠ)',
  '(˘･_･˘)',
  '(┬┬﹏┬┬)',
  '(´･ω･`)?',
  'X﹏X',
  '＞︿＜',
];

class CustomErrorWidget extends HookWidget {
  final String errorString;
  final Function()? onRefresh;

  const CustomErrorWidget(this.errorString, this.onRefresh, {super.key});

  @override
  Widget build(BuildContext context) {
    final errorFace = useMemoized(
      () => errorFaces[Random().nextInt(errorFaces.length)],
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              errorFace,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'Ой, ошибка..',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            Text(
              errorString,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            FilledButton.icon(
              onPressed: onRefresh,
              label: const Text(
                'Повторить',
              ),
              icon: const Icon(Icons.refresh_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
