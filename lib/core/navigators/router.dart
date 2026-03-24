import 'package:belyfted/belyfted.dart';

Route<T> onGenerateRoute<T>(RouteSettings settings) {
  final route = settings.name ?? RouteService.startVerification;
  final page = RouteService.getPageForRoute(route, settings: settings);
  return RouteService.randomTransition(page, settings: settings) as Route<T>;
}

class RouteService {
  static const String startVerification = '/';
  static const String verificationResult = '/verification-result';
  static const String kybView = '/kyb-view';
  static const String checkStatus = '/check-status';

  // Random generator
  static final Random _random = Random();
  static Widget getPageForRoute(
    String route, {
    required RouteSettings settings,
  }) {
    switch (route) {
      case startVerification:
        return const StartKYBView();
      case kybView:
        return const KYBView();
      case checkStatus:
        final submission = settings.arguments as KYBSubmissionModel;
        return CheckStatusView(submission: submission);
      case verificationResult:
        final option = settings.arguments as String?;
        if (option == null) {
          return const UnknownRouteView(reason: 'Missing arguments');
        }
        return KYBResultView(option: option);
      default:
        return UnknownRouteView(reason: 'No route defined for $route');
    }
  }

  // Random transition selector
  static Route randomTransition(
    Widget page, {
    required RouteSettings settings,
  }) {
    final transitions = [
      fadeTransitionRoute,
      slideTransition,
      scaleTransition,
      rotateTransition,
    ];

    final selectedTransition = transitions[_random.nextInt(transitions.length)];
    return selectedTransition(page, settings: settings);
  }

  static Route fadeTransitionRoute(
    Widget page, {
    required RouteSettings settings,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation.drive(CurveTween(curve: Curves.easeInOut)),
          child: child,
        );
      },
    );
  }

  static Route slideTransition(
    Widget page, {
    required RouteSettings settings,
    Offset? beginOffset,
  }) {
    final offsets = [
      const Offset(1, 0),
      const Offset(-1, 0),
      const Offset(0, 1),
      const Offset(0, -1),
    ];
    final offset = beginOffset ?? offsets[_random.nextInt(offsets.length)];

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(
          begin: offset,
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOutQuart));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static Route scaleTransition(Widget page, {required RouteSettings settings}) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scale = Tween<double>(
          begin: 0.9,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
        return ScaleTransition(scale: scale, child: child);
      },
    );
  }

  static Route rotateTransition(
    Widget page, {
    required RouteSettings settings,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final rotate = Tween<double>(
          begin: 0.95,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: rotate, child: child),
        );
      },
    );
  }
}
