import 'package:belyfted/belyfted.dart';

class BelyftedKYB extends StatelessWidget {
  const BelyftedKYB({super.key});

  @override
  Widget build(BuildContext context) {
    final initialRoute = RouteService.startVerification;
    return MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      onGenerateRoute: onGenerateRoute,
      navigatorKey: navigations.navKey,
      initialRoute: initialRoute,
      onUnknownRoute: (settings) => RouteService.fadeTransitionRoute(
        UnknownRouteView(reason: 'No route defined for ${settings.name}'),
        settings: settings,
      ),
      theme: ThemeData(
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.belyftedPrimaryColor,
          primary: AppColors.belyftedPrimaryColor,
        ),
        hintColor: AppColors.belyftedNeutralColor.shade500,
      ),
      builder: (context, child) {
        Vize.init(context, figmaHeight: 926, figmaWidth: 438);
        return child!;
      },
    );
  }
}
