import 'package:belyfted/belyfted.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.textColor,
    required this.backgroundColor,
    this.borderRadius,
    this.padding,
  });

  final String label;
  final Color textColor;
  final Color backgroundColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? ps(h: 8, v: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 28.r),
        color: backgroundColor,
      ),
      child: TextWidget(
        text: label,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        textColor: textColor,
      ),
    );
  }
}
