import 'package:belyfted/belyfted.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    this.fontWeight,
    this.fontSize,
    this.style,
    this.height,
    this.textAlign,
    this.overflow,
    this.textColor,
    this.softWrap = true,
    this.fontStyle,
  });

  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextStyle? style;
  final double? height;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final Color? textColor;
  final bool softWrap;
  final FontStyle? fontStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      overflow: overflow,
      softWrap: softWrap,
      text,
      style:
          style ??
          TextStyle(
            fontStyle: fontStyle,
            fontWeight: fontWeight,
            fontSize: fontSize?.ts,
            height: height,
            color: textColor ?? AppColors.darkColor,
          ),
    );
  }
}
