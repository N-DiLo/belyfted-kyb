import 'package:belyfted/belyfted.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.showCursor,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.cursorColor,
    this.maxLines = 1,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.autocorrect = true,
    this.obscuringCharacter = '•',
    this.textCapitalization = TextCapitalization.none,
    this.hintText,
    this.labelText,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixTapped,
    this.constraints,
    this.hasDrop = false,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final Color? fillColor;
  final bool autofocus;
  final bool readOnly;
  final bool? showCursor;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final int? maxLines;
  final int? maxLength;
  final BoxConstraints? constraints;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function()? suffixTapped;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Color? cursorColor;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool hasDrop;

  @override
  State<CustomTextfield> createState() {
    return _CustomTextfieldState();
  }
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    final hasLabel = widget.labelText != null && widget.labelText!.isNotEmpty;

    return Padding(
      padding: hasLabel ? po(b: 16.r, t: 8.r) : po(b: 16.r, t: 4.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasLabel) ...[
            TextWidget(
              text: widget.labelText!,
              fontSize: widget.hasDrop ? 14 : 16,
              textColor: widget.hasDrop
                  ? AppColors.belyftedNeutralColor.shade800
                  : AppColors.darkColor,
              fontWeight: widget.hasDrop ? FontWeight.w500 : FontWeight.w400,
            ),
          ],
          TextFormField(
            style: TextStyle(
              fontSize: 18.ts,
              color: AppColors.darkColor,
              fontWeight: FontWeight.w400,
            ),
            autocorrect: widget.autocorrect,
            focusNode: widget.focusNode,
            textInputAction: widget.textInputAction,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            textAlign: widget.textAlign,
            textCapitalization: widget.textCapitalization,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            cursorColor: widget.cursorColor,
            keyboardType: widget.keyboardType,
            obscuringCharacter: widget.obscuringCharacter,
            obscureText: widget.obscureText,
            readOnly: widget.readOnly,
            showCursor: widget.showCursor,
            controller: widget.controller,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            autofocus: widget.autofocus,
            decoration: InputDecoration(
              suffixIconConstraints: widget.readOnly
                  ? BoxConstraints(minWidth: w(.1))
                  : widget.constraints,
              prefixIconConstraints: widget.readOnly
                  ? BoxConstraints(minWidth: w(.1))
                  : widget.constraints,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon != null
                  ? GestureDetector(
                      onTap: widget.suffixTapped,
                      child: !widget.hasDrop
                          ? widget.suffixIcon
                          : ImageWidget(url: AppImages.arrowDown),
                    )
                  : null,
              filled: true,
              fillColor:
                  widget.fillColor ??
                  (widget.hasDrop
                      ? AppColors.belyftedPrimaryColor.shade200
                      : AppColors.belyftedPrimaryColor.shade100),
              hintStyle: TextStyle(
                fontSize: 18.ts,
                fontWeight: FontWeight.w500,
                color: AppColors.belyftedNeutralColor.shade500,
              ),
              hintText: widget.hintText ?? '',
              contentPadding: 16.pa,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.belyftedNeutralColor.shade200,
                  width: 1.r,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.belyftedNeutralColor.shade200,
                  width: 1.r,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.belyftedNeutralColor.shade200,
                  width: 1.r,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.belyftedNeutralColor.shade200,
                  width: 1.r,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.belyftedNeutralColor.shade200,
                  width: 1.r,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.belyftedNeutralColor.shade200,
                  width: 1.r,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
