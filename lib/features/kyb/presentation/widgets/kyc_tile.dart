import 'package:belyfted/belyfted.dart';

class KycTile extends StatelessWidget {
  const KycTile({required this.user, super.key});
  final KycItem user;

  @override
  Widget build(BuildContext context) {
    final config = KycStats.of(user.status);
    final initial = user.email.isNotEmpty ? user.email[0].toUpperCase() : '?';

    return Padding(
      padding: EdgeInsets.only(bottom: 26.r),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 32.r,
          width: 32.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.belyftedPurpleColor.shade50,
          ),
          child: TextWidget(
            text: initial,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            textColor: AppColors.belyftedPurpleColor,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextWidget(
                text: user.email,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            8.fws,
            StatusBadge(
              label: config.label,
              textColor: config.textColor,
              backgroundColor: config.backgroundColor,
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: user.role,
              fontWeight: FontWeight.w500,
              fontSize: 12,
              textColor: AppColors.belyftedNeutralColor.shade500,
            ),
            if (user.status == KycStatus.pending && user.onResendLink != null)
              GestureDetector(
                onTap: user.onResendLink,
                child: TextWidget(
                  text: 'Resend Link',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  textColor: AppColors.belyftedBlueColor.shade800,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
