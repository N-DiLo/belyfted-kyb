import 'package:belyfted/belyfted.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
  });

  final String image;
  final String title;
  final String subtitle;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? ps(h: 16.r, v: 10.r),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.belyftedPrimaryColor.shade50,
        borderRadius: borderRadius ?? BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWidget(url: image),
          8.fhs,
          TextWidget(
            text: title,
            textColor: AppColors.belyftedNeutralColor.shade800,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          TextWidget(
            text: subtitle,
            textColor: AppColors.belyftedNeutralColor.shade500,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
