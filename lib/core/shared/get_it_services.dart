import 'package:belyfted/belyfted.dart';

final locator = GetIt.instance;

Future<void> belfyted() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  locator.registerLazySingleton<Navigations>(() => Navigations());
}

Navigations navigations = locator.get<Navigations>();
