import 'package:belyfted/belyfted.dart';

class KYBView extends ConsumerStatefulWidget {
  const KYBView({super.key});

  @override
  ConsumerState<KYBView> createState() => _KYBViewState();
}

class _KYBViewState extends ConsumerState<KYBView> {
  final PageController _pageController = PageController();
  int _currentPage = 1;
  static const int _totalPages = 4;

  void _onPageChanged(int value) => setState(() => _currentPage = value + 1);

  void _onComplete() {
    final submission = ref.read(kybSubmissionProvider).toModel();
    navigations.pushReplacementNamed(
      RouteService.checkStatus,
      arguments: submission,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Padding(
            padding: po(t: 10, b: 24),
            child: StepIndicator(
              currentPage: _currentPage,
              totalPages: _totalPages,
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: _onPageChanged,
              children: [
                BusinessInfoView(pageController: _pageController),
                BusinessRegInfoView(pageController: _pageController),
                BeneficiaryOfficerView(pageController: _pageController),
                DocumentUploadView(
                  pageController: _pageController,
                  onComplete: _onComplete,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
