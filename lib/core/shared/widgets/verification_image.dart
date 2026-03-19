import 'package:belyfted/belyfted.dart';

class VerificationImage extends StatelessWidget {
  const VerificationImage({
    super.key,
    required this.child,
    required this.color,
    required this.shadowColor,
    this.shape = BoxShape.circle,
    this.borderRadius,
  });
  final Widget child;
  final Color color;
  final Color shadowColor;
  final BoxShape shape;
  final BorderRadiusGeometry? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56.fw,
      height: 56.fh,
      padding: 12.pa,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: color,
        shape: shape,
        boxShadow: [
          BoxShadow(
            color: shadowColor.withValues(alpha: .2),
            offset: Offset(4, 8),
            blurRadius: 12.r,
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
