import 'package:belyfted/belyfted.dart';

class DocumentUploadField extends StatelessWidget {
  const DocumentUploadField({
    super.key,
    required this.label,
    this.fileName,
    this.onFileSelected,
  });

  final String label;
  final String? fileName;
  final void Function(String fileName, String filePath)? onFileSelected;

  Future<void> _showPickerOptions(BuildContext context) async {
    await CustomDialog.show(
      context: context,
      title: 'Upload Document',
      child: PickOptions(
        onFileSelected: (name, path) {
          navigations.pop();
          onFileSelected?.call(name, path);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: po(b: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(text: label, fontWeight: FontWeight.w500, fontSize: 14),
          8.fhs,
          GestureDetector(
            onTap: () => _showPickerOptions(context),
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(12.r),
                dashPattern: const [6, 4],
                color: AppColors.belyftedNeutralColor.shade500,
                strokeWidth: 0.5,
              ),
              child: Container(
                width: double.infinity,
                padding: 16.pa,
                decoration: BoxDecoration(
                  color: AppColors.belyftedPrimaryColor.shade200,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageWidget(
                        url: fileName != null
                            ? AppImages.documentUpload
                            : AppImages.documentUpload,
                      ),
                      16.fws,
                      Flexible(
                        child: TextWidget(
                          text: fileName ?? 'Click to choose file',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textColor: fileName != null
                              ? AppColors.belyftedPrimaryColor
                              : AppColors.belyftedNeutralColor.shade500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
