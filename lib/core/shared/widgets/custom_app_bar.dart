import 'package:belyfted/belyfted.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.isText = true,
    this.centerTitle = false,
    this.automaticallyImplyLeading = false,
    this.showBackButton = true,
    this.leadingIcon,
    this.onLeadingIconTap,
    this.backgroundColor = AppColors.scaffoldBackgroundColor,
    this.dividerHeight = 5.0,
    this.bottomWidget,
    this.elevation = 0,
  });

  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool isText;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final bool showBackButton;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingIconTap;
  final Color backgroundColor;
  final double dividerHeight;
  final Widget? bottomWidget;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      centerTitle: centerTitle,
      leading: showBackButton
          ? GestureDetector(
              onTap: onLeadingIconTap ?? () => navigations.pop(),
              child: ImageWidget(url: AppImages.backButton),
            )
          : null,
      title: isText
          ? TextWidget(
              text: title ?? '',
              fontSize: 16,
              fontWeight: FontWeight.w700,
            )
          : titleWidget,
      actions: actions,
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, dividerHeight),
        child: bottomWidget ?? const SizedBox.shrink(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + dividerHeight);
}
