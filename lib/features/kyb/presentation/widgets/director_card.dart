import 'package:belyfted/belyfted.dart';

class DirectorCard extends StatelessWidget {
  const DirectorCard({
    super.key,
    required this.director,
    required this.onEdit,
    this.onDelete,
  });

  final DirectorItem director;
  final VoidCallback onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(12.r),
        dashPattern: const [6, 4],
        color: AppColors.belyftedPrimaryColor.shade500,
        strokeWidth: 0.5,
      ),
      child: Container(
        padding: 16.pa,
        decoration: BoxDecoration(
          color: AppColors.belyftedPrimaryColor.shade200,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: director.name,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    textColor: AppColors.belyftedNeutralColor.shade800,
                  ),
                  TextWidget(
                    text: director.subtitle,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    textColor: AppColors.belyftedNeutralColor.shade500,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onEdit,
              child: ImageWidget(url: AppImages.edit),
            ),
            if (onDelete != null) ...[
              24.fws,
              GestureDetector(
                onTap: onDelete,
                child: ImageWidget(url: AppImages.delete),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
