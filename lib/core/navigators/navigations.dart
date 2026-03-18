import 'package:belyfted/belyfted.dart';

class Navigations<T, U> {
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  Future<T?>? pushNamed(String routeName, {Object? arguments}) async =>
      navKey.currentState?.pushNamed<T>(routeName, arguments: arguments);

  Future<T?> push(Widget page, {Object? arguments}) async =>
      navKey.currentState?.push<T>(
        MaterialPageRoute(
          builder: (c) => page,
          settings: RouteSettings(arguments: arguments),
        ),
      );

  Future pushReplacement(Widget page, {Object? result}) async =>
      navKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (c) => page),
        result: result,
      );

  Future<T?>? pushReplacementNamed(
    String routeName, {
    Object? arguments,
  }) async => navKey.currentState?.pushReplacementNamed<T, U>(
    routeName,
    arguments: arguments,
  );

  Future<T?>? pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
    bool keepPreviousPages = false,
  }) async => navKey.currentState?.pushNamedAndRemoveUntil<T>(
    routeName,
    (Route<dynamic> route) => keepPreviousPages,
    arguments: arguments,
  );

  Future<T?>? pushAndRemoveUntil(
    Widget page, {
    bool keepPreviousPages = false,
  }) async => navKey.currentState?.pushAndRemoveUntil<T>(
    MaterialPageRoute(builder: (c) => page),
    (Route<dynamic> route) => keepPreviousPages,
  );

  Future<bool?>? maybePop([Object? arguments]) async =>
      navKey.currentState?.maybePop(arguments);

  bool? canPop() => navKey.currentState?.canPop();

  void pop([T? result]) => navKey.currentState?.pop<T>(result);
}
