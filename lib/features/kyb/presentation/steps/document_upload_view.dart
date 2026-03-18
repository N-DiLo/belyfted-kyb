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
        TextWidget(
          text: 'Upload validation documents (Max 1MB each)',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          textColor: AppColors.belyftedNeutralColor,
        ),
        32.fhs,
        DocumentUploadField(
          label: 'Business Incorporation Certificate',
          onTap: () async {},
        ),
        DocumentUploadField(
          label: 'Articles of Memorandum',
          onTap: () async {},
        ),
        DocumentUploadField(
          label: 'Shares of the Business',
          onTap: () async {},
        ),
        DocumentUploadField(label: 'Proof of Address', onTap: () async {}),
        DocumentUploadField(label: 'Proof of ID', onTap: () async {}),
        DocumentUploadField(label: 'Other Documents', onTap: () async {}),
        101.fhs,
        CustomButton(
          onTap: () async {
            widget.onComplete();
          },
          text: 'Continue',
          enabled: true,
        ),
        73.fhs,
      ],
    );
  }
}
