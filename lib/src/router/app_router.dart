import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';
import '../pages/settings/settings_page.dart';
import '../services/storage_service.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'rootNavigatorKey');

final appRouterProvider = Provider.autoDispose<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: notifier,
    routes: notifier.routes,
    redirect: notifier.redirect,
    initialLocation: '/splash',
  );
}, name: 'appRouterProvider');

final routerNotifierProvider =
    AutoDisposeAsyncNotifierProvider<RouterNotifier, void>(() {
  return RouterNotifier();
}, name: 'routerNotifierProvider');

class RouterNotifier extends AutoDisposeAsyncNotifier<void>
    implements Listenable {
  VoidCallback? routerListener;
  bool userLogin = false;

  @override
  Future<void> build() async {
    userLogin = StorageService.instance.userGroup != '';

    ref.listenSelf((_, __) {
      if (state.isLoading) return;
      routerListener?.call();
    });
  }

  String? redirect(BuildContext context, GoRouterState state) {
    if (this.state.isLoading || this.state.hasError) {
      return null;
    }

    final String location = state.uri.toString();

    final isSplash = location == '/splash';

    if (isSplash) {
      return userLogin ? '/' : '/login';
    }

    final isLoggingIn = location == '/login';

    if (isLoggingIn) return userLogin ? '/' : null;

    return userLogin ? null : '/splash';
  }

  List<RouteBase> get routes => [
        GoRoute(
          path: '/splash',
          name: 'splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: const LoginPage(),
          ),
        ),
        GoRoute(
          path: '/',
          redirect: (_, __) => '/home',
        ),
        GoRoute(
          path: '/home',
          name: 'home',
          pageBuilder: (context, state) => FadeTransitionPage(
            key: state.pageKey,
            child: const HomePage(),
          ),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          pageBuilder: (context, state) {
            return SharedAxisTransition(
              key: state.pageKey,
              child: const SettingsPage(),
            );
          },
        ),
      ];

  @override
  void addListener(VoidCallback listener) {
    routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    routerListener = null;
  }
}

class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({
    required ValueKey<String> key,
    required Widget child,
  }) : super(
          key: key,
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
                opacity: animation.drive(_curveTween), child: child);
          },
          child: child,
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeOutCirc);
}

class SharedAxisTransition extends CustomTransitionPage<void> {
  SharedAxisTransition({
    required ValueKey<String> key,
    required Widget child,
  }) : super(
          key: key,
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: _fadeInTransition.animate(animation),
              child: AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget? child) {
                  return Transform.translate(
                    offset: slideInTransition.evaluate(animation),
                    child: child,
                  );
                },
                child: child,
              ),
            );
          },
          child: child,
        );

  static final Animatable<double> _fadeInTransition = CurveTween(
    curve: decelerateEasing,
  ).chain(CurveTween(curve: const Interval(0.3, 1.0)));

  static final Animatable<Offset> slideInTransition = Tween<Offset>(
    begin: const Offset(30.0, 0.0),
    end: Offset.zero,
  ).chain(CurveTween(curve: standardEasing));
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
