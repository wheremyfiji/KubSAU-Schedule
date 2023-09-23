import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/home_page_provider.dart';
import '../../services/storage_service.dart';
import '../../utils/app_utils.dart';
import '../../utils/extensions/buildcontext.dart';
import '../../utils/extensions/string.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/lesson_card.dart';

final _tabs = <int, String>{
  1: 'Понедельник',
  2: 'Вторник',
  3: 'Среда',
  4: 'Четверг',
  5: 'Пятница',
  6: 'Суббота',
};

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homePageProvider);
    final currentTimeOfDay = useState(TimeOfDay.now());
    final tabController = useTabController(
      initialLength: 6,
    );

    useEffect(
      () {
        final timer = Timer.periodic(const Duration(seconds: 10), (time) {
          currentTimeOfDay.value = TimeOfDay.now();
        });
        return () => timer.cancel();
      },
    );

    useEffect(() {
      tabController.animateTo(provider.currentDayOfWeek - 1);
      return null;
    }, [provider.scheduleAsync]);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              forceElevated: innerBoxIsScrolled,
              title: const Text('Расписание'),
              actions: [
                IconButton(
                  onPressed: () => context.pushNamed('settings'),
                  icon: const Icon(Icons.settings),
                ),
              ],
              bottom: TabBar(
                controller: tabController,
                isScrollable: true,
                indicatorWeight: 1.5,
                //dividerColor: Colors.transparent,
                splashBorderRadius: BorderRadius.circular(12.0),
                tabs: _tabs.values
                    .map(
                      (e) => Tab(
                        text: e,
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
          ];
        },
        body: SafeArea(
          top: false,
          bottom: false,
          child: provider.scheduleAsync.when(
            data: (data) {
              final weeks = data.weeks;

              if (weeks == null) {
                return const Text('weeks == null');
              }

              return TabBarView(
                controller: tabController,
                children: _tabs.keys.map((e) {
                  final day =
                      weeks[provider.selectedWeek].lessons!.firstWhereOrNull(
                            (element) => element.dayOfWeek == e,
                          );

                  if (day == null) {
                    return RefreshIndicator(
                      onRefresh: () async => ref.invalidate(homePageProvider),
                      child: Stack(
                        children: <Widget>[ListView(), const NoLessonsWidget()],
                      ),
                    );
                  }

                  final lessons = day.lessons;

                  if (lessons == null) {
                    return const Center(child: Text('lessons == null'));
                  }

                  return RefreshIndicator(
                    // onRefresh: () =>
                    //     ref.refresh(scheduleApiProvider(group).future),
                    onRefresh: () async => ref.invalidate(homePageProvider),
                    child: CustomScrollView(
                      key: PageStorageKey<String>('Tab $e'),
                      scrollDirection: Axis.vertical,
                      slivers: [
                        const SliverPadding(padding: EdgeInsets.only(top: 16)),
                        SliverList.builder(
                          itemCount: lessons.length,
                          itemBuilder: (context, index) {
                            final lesson = lessons[index];

                            final lessonNumber = lesson.lessonNumber ?? 1;
                            final time = AppUtils().getLessonTime(lessonNumber);

                            final current = (provider.currentDayOfWeek ==
                                    lesson.dayOfWeek) &&
                                AppUtils().timeIsBetween(
                                  currentTimeOfDay.value,
                                  time.start,
                                  time.end,
                                ) &&
                                DateTime.now().weekday != DateTime.sunday;

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                              child: LessonCard(
                                lesson: lesson,
                                time: time,
                                current: current,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
            error: (e, _) => Center(
                child: CustomErrorWidget(
              e.toString(),
              () => ref.invalidate(homePageProvider),
            )),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
        shadowColor: Colors.transparent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            context.mediaQuery.viewPadding.bottom,
          ),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    StorageService.instance.userGroup.capitalizeFirstTwoChars(),
                    style: context.textTheme.titleMedium,
                  ),
                  Text(
                    provider.selectedWeek == 1 ? '2 неделя' : '1 неделя',
                  ),

                  // Wrap(
                  //   spacing: 4,
                  //   children: [
                  //     CompactTextButton(
                  //       label: '1 неделя',
                  //       selected: provider.selectedWeek == 0,
                  //       onPressed: () => provider.changeWeek(0),
                  //     ),
                  //     const Text('•'),
                  //     CompactTextButton(
                  //       label: '2 неделя',
                  //       selected: provider.selectedWeek == 1,
                  //       onPressed: () => provider.changeWeek(1),
                  //     ),
                  //     IconButton(
                  //       onPressed: () {},
                  //       icon: const Icon(Icons.restore),
                  //       style: const ButtonStyle(
                  //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //         visualDensity: VisualDensity.compact,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              const Spacer(),
              FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoLessonsWidget extends StatelessWidget {
  const NoLessonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '(～￣▽￣)～',
            style: context.textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Занятий нет',
              style: context.textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class CompactTextButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onPressed;

  const CompactTextButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? context.colorScheme.primary
        : context.colorScheme.onBackground;

    return Material(
      borderRadius: BorderRadius.circular(4),
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: color,
          ),
        ),
      ),
    );
  }
}
