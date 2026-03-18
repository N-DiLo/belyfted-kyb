import 'package:belyfted/belyfted.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.child,
    this.title,
    this.padding,
    this.showClose = true,
    this.onClose,
  });

  final Widget child;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final bool showClose;
  final VoidCallback? onClose;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool barrierDismissible = true,
    bool showClose = true,
    VoidCallback? onClose,
    EdgeInsetsGeometry? padding,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => CustomDialog(
        title: title,
        padding: padding,
        showClose: showClose,
        onClose: onClose,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: padding ?? 14.pa,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null || showClose) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (title != null)
                    Expanded(
                      child: TextWidget(
                        text: title!,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  else
                    const Spacer(),
                  if (showClose)
                    GestureDetector(
                      onTap: onClose ?? () => navigations.pop(),
                      child: Container(
                        padding: 4.pa,
                        decoration: BoxDecoration(
                          color: AppColors.belyftedNeutralColor.shade200,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          size: 18.r,
                          color: AppColors.darkColor,
                        ),
                      ),
                    ),
                ],
              ),
              14.fhs,
            ],
            child,
          ],
        ),
      ),
    );
  }
}
