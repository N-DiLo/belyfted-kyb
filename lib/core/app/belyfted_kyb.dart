import 'package:belyfted/belyfted.dart';

class BelyftedKYB extends StatelessWidget {
  const BelyftedKYB({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      theme: ThemeData(fontFamily: 'Montserrat'),
      builder: (context, child) {
        Vize.init(context, figmaHeight: 926, figmaWidth: 438);
        return child!;
      },
    );
  }
}
