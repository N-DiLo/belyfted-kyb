import 'package:belyfted/belyfted.dart';

class DottedBorderButton extends StatelessWidget {
  const DottedBorderButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: po(b: 32),
      child: GestureDetector(
        onTap: onTap,
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            radius: Radius.circular(12.r),
            dashPattern: const [6, 4],
            color: AppColors.belyftedPrimaryColor.shade500,
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
                  ImageWidget(url: AppImages.add),
                  16.fws,
                  TextWidget(
                    text: label,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.belyftedPrimaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
