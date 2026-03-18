import 'package:belyfted/belyfted.dart';

class BusinessInfoView extends StatefulWidget {
  const BusinessInfoView({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<BusinessInfoView> createState() => _BusinessInfoViewState();
}

class _BusinessInfoViewState extends State<BusinessInfoView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: ps(h: 16),
      children: [
        24.fhs,
        TextWidget(
          text: 'Business Information',
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ],
    );
  }
}
