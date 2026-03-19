import 'package:belyfted/belyfted.dart';

class DocumentUploadView extends ConsumerStatefulWidget {
  final void Function() onComplete;
  const DocumentUploadView({
    super.key,
    required this.pageController,
    required this.onComplete,
  });

  final PageController pageController;

  @override
  ConsumerState<DocumentUploadView> createState() => _DocumentUploadViewState();
}

class _DocumentUploadViewState extends ConsumerState<DocumentUploadView> {
  final Map<String, String> _uploadedFiles = {};
  final _canProceed = ValueNotifier<bool>(false);

  static const _requiredLabels = [
    'Business Incorporation Certificate',
    'Articles of Memorandum',
    'Shares of the Business',
    'Proof of Address',
    'Proof of ID',
    'Other Documents',
  ];

  void _onFileSelected(String label, String fileName, String filePath) {
    setState(() => _uploadedFiles[label] = fileName);
    _canProceed.value = _allFilesUploaded;
  }

  bool get _allFilesUploaded =>
      _requiredLabels.every((label) => _uploadedFiles.containsKey(label));

  @override
  void initState() {
    super.initState();
    _canProceed.value = _allFilesUploaded;
  }

  @override
  void dispose() {
    _canProceed.dispose();
    super.dispose();
  }

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
        ..._requiredLabels.map(
          (label) => DocumentUploadField(
            label: label,
            fileName: _uploadedFiles[label],
            onFileSelected: (name, path) => _onFileSelected(label, name, path),
          ),
        ),
        101.fhs,
        CustomButton(
          onTap: () async {
            ref
                .read(kybSubmissionProvider.notifier)
                .updateUploadedFiles(Map.from(_uploadedFiles));
            widget.onComplete();
          },
          text: 'Continue',
          enabledListenable: _canProceed,
        ),
        73.fhs,
      ],
    );
  }
}
