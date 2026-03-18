import 'package:belyfted/belyfted.dart';

enum ButtonType { primary, secondary, outline }

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    this.color,
    this.width,
    this.height,
    this.borderRadius,
    this.enabled = false,
    this.type = ButtonType.primary,
    this.enabledListenable,
    required this.text,
    this.loadingText,
    this.isLoading = false,
    this.fontSize,
    this.fontWeight,
    this.icon,
    this.iconSpacing,
  });

  final Future<void> Function()? onTap;
  final Color? color;
  final double? width;
  final double? height;
  final ButtonType type;
  final bool enabled;
  final bool isLoading;
  final BorderRadiusGeometry? borderRadius;
  final ValueListenable<bool>? enabledListenable;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String text;
  final String? loadingText;
  final Widget? icon;
  final double? iconSpacing;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _isEnabled = widget.enabledListenable?.value ?? widget.enabled;
    widget.enabledListenable?.addListener(_buttonEnabled);
  }

  @override
  void didUpdateWidget(covariant CustomButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabledListenable != widget.enabledListenable) {
      oldWidget.enabledListenable?.removeListener(_buttonEnabled);
      widget.enabledListenable?.addListener(_buttonEnabled);
    }
    if (widget.enabledListenable == null &&
        oldWidget.enabled != widget.enabled) {
      setState(() => _isEnabled = widget.enabled);
    }
  }

  void _buttonEnabled() {
    final newValue = widget.enabledListenable?.value ?? widget.enabled;
    if (newValue != _isEnabled) setState(() => _isEnabled = newValue);
  }

  @override
  void dispose() {
    widget.enabledListenable?.removeListener(_buttonEnabled);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = !_isEnabled || widget.isLoading || widget.onTap == null;
    final label = widget.isLoading && widget.loadingText != null
        ? widget.loadingText!
        : widget.text;
    final textColor = _getTextColor(isDisabled);

    final isOutline = widget.type == ButtonType.outline;

    Widget content;
    if (widget.isLoading) {
      content = SizedBox(
        height: 20.r,
        width: 20.r,
        child: CircularProgressIndicator(strokeWidth: 2, color: textColor),
      );
    } else if (widget.icon != null) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.icon!,
          SizedBox(width: widget.iconSpacing ?? 8.r),
          TextWidget(
            text: label,
            textColor: textColor,
            fontSize: widget.fontSize ?? 18,
            fontWeight: widget.fontWeight ?? FontWeight.w400,
          ),
        ],
      );
    } else {
      content = TextWidget(
        text: label,
        textColor: textColor,
        fontSize: widget.fontSize ?? 18,
        fontWeight: widget.fontWeight ?? FontWeight.w400,
      );
    }

    return GestureDetector(
      onTap: isDisabled ? null : widget.onTap,
      child: AnimatedContainer(
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        width: widget.width ?? 378.fw,
        height: widget.height ?? 56.fh,
        padding: 10.pa,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(16.r),
          color: isOutline ? Colors.transparent : _buttonColor(isDisabled),
          border: isOutline
              ? Border.all(
                  color: isDisabled
                      ? AppColors.belyftedInactiveColor
                      : (widget.color ?? AppColors.belyftedPrimaryColor),
                  width: 1.5,
                )
              : null,
        ),
        child: content,
      ),
    );
  }

  Color _buttonColor(bool isDisabled) {
    if (widget.type == ButtonType.primary) {
      return isDisabled
          ? AppColors.belyftedInactiveColor
          : (widget.color ?? AppColors.belyftedPrimaryColor);
    }
    return isDisabled
        ? AppColors.belyftedInactiveColor
        : (widget.color ?? AppColors.belyftedInactiveColor);
  }

  Color _getTextColor(bool isDisabled) {
    if (widget.type == ButtonType.outline) {
      return isDisabled
          ? AppColors.belyftedInactiveColor
          : (widget.color ?? AppColors.belyftedPrimaryColor);
    }
    if (widget.type == ButtonType.secondary) {
      return isDisabled
          ? AppColors.belyftedInactiveTextColor
          : AppColors.whiteColor;
    }
    return AppColors.whiteColor;
  }
}
