import 'package:belyfted/belyfted.dart';

class UnknownRouteView extends StatelessWidget {
  const UnknownRouteView({super.key, this.reason = 'Unknown route'});
  final String reason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.belyftedNeutralColor.shade500,
            ),
            16.fhs,
            TextWidget(
              text: reason,
              textColor: AppColors.belyftedNeutralColor.shade800,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            8.fhs,
            TextWidget(
              text: 'Please go back and try again.',
              textColor: AppColors.belyftedNeutralColor.shade500,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}
