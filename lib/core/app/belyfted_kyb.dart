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
      theme: ThemeData(
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        colorSchemeSeed: AppColors.belyftedPrimaryColor,
        primaryColor: AppColors.belyftedPrimaryColor,
        hintColor: AppColors.belyftedNeutralColor.shade500,
      ),
      builder: (context, child) {
        Vize.init(context, figmaHeight: 926, figmaWidth: 438);
        return child!;
      },
    );
  }
}
