import 'package:belyfted/belyfted.dart';

class KYBView extends StatefulWidget {
  const KYBView({super.key});

  @override
  State<KYBView> createState() {
    return _KYBViewState();
  }
}

class _KYBViewState extends State<KYBView> {
  PageController pageController = PageController();
  int currentPage = 1;
  int totalPages = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (value) => setState(() {
          currentPage = value + 1;
        }),
        children: [
          BusinessInfoView(pageController: pageController),
          BusinessRegInfoView(pageController: pageController),
          BeneficiaryOfficerView(pageController: pageController),
          DocumentUploadView(
            pageController: pageController,
            onComplete: () {
              navigations.pushNamed(RouteService.verificationResult);
            },
          ),
        ],
      ),
    );
  }
}
