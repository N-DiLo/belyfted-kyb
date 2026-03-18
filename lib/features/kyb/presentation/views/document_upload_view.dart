import 'package:belyfted/belyfted.dart';

class DocumentUploadView extends StatefulWidget {
  final void Function() onComplete;
  const DocumentUploadView({
    super.key,
    required this.pageController,
    required this.onComplete,
  });

  final PageController pageController;

  @override
  State<DocumentUploadView> createState() => _DocumentUploadViewState();
}

class _DocumentUploadViewState extends State<DocumentUploadView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: ps(h: 16),
      children: [
        24.fhs,
        TextWidget(
          text: 'Business Official Documents',
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ],
    );
  }
}
