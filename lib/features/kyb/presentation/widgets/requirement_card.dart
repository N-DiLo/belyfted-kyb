import 'package:belyfted/belyfted.dart';

class RequirementsCard extends StatelessWidget {
  const RequirementsCard({
    super.key,
    required this.items,
    this.heading = 'What you will need:',
    this.backgroundColor,
    this.borderRadius,
    this.padding,
  });

  final List<String> items;
  final String heading;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? ps(h: 16.r, v: 10.r),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.belyftedPrimaryColor.shade100,
        borderRadius: borderRadius ?? BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: heading,
            textColor: AppColors.belyftedNeutralColor.shade800,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          14.fhs,
          ...items.map((item) => BulletItem(text: item)),
        ],
      ),
    );
  }
}

class BulletItem extends StatelessWidget {
  const BulletItem({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: po(b: 16.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: po(r: 8.r),
            child: Container(
              width: 5.r,
              height: 5.r,
              decoration: BoxDecoration(
                color: AppColors.belyftedNeutralColor.shade500,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: TextWidget(
              text: text,
              textColor: AppColors.belyftedNeutralColor.shade500,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
