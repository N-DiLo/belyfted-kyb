import 'package:belyfted/belyfted.dart';

class BusinessRegInfoView extends StatefulWidget {
  const BusinessRegInfoView({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<BusinessRegInfoView> createState() => _BusinessRegInfoViewState();
}

class _BusinessRegInfoViewState extends State<BusinessRegInfoView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: ps(h: 16),
      children: [
        24.fhs,
        TextWidget(
          text: 'Business Registration Info',
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ],
    );
  }
}
