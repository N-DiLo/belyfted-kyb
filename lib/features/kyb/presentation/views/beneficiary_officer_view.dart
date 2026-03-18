import 'package:belyfted/belyfted.dart';

class BeneficiaryOfficerView extends StatefulWidget {
  const BeneficiaryOfficerView({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<BeneficiaryOfficerView> createState() => _BeneficiaryOfficerViewState();
}

class _BeneficiaryOfficerViewState extends State<BeneficiaryOfficerView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: ps(h: 16),
      children: [
        24.fhs,
        TextWidget(
          text: 'Ultimate Beneficiary Officer',
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ],
    );
  }
}
