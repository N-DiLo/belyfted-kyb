import 'package:belyfted/belyfted.dart';

class KycCard extends StatelessWidget {
  const KycCard({super.key, required this.userType, this.verifiedCount});

  final List<KycItem> userType;
  final int? verifiedCount;

  int get _verifiedCount =>
      verifiedCount ??
      userType.where((d) => d.status == KycStatus.verified).length;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: 'Director KYC Status',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              textColor: AppColors.belyftedNeutralColor.shade800,
            ),
            StatusBadge(
              label: '$_verifiedCount/${userType.length} Verified',
              textColor: AppColors.belyftedBlueColor.shade800,
              backgroundColor: AppColors.belyftedPrimaryColor.shade50,
              borderRadius: 28.r,
              padding: ps(h: 16, v: 8),
            ),
          ],
        ),
        19.fhs,
        Divider(
          thickness: 0.5.r,
          color: AppColors.belyftedNeutralColor.shade200,
        ),
        ...userType.map((director) => KycTile(user: director)),
      ],
    );
  }
}
