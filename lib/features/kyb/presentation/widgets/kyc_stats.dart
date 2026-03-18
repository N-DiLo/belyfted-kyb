import 'package:belyfted/belyfted.dart';

enum KycStatus { verified, pending, failed, notStarted }

class KycStats {
  const KycStats({
    required this.label,
    required this.textColor,
    required this.backgroundColor,
  });
  final String label;
  final Color textColor;
  final Color backgroundColor;

  static KycStats of(KycStatus status) {
    switch (status) {
      case KycStatus.verified:
        return KycStats(
          label: 'Verified',
          textColor: AppColors.belyftedGreenColor.shade800,
          backgroundColor: AppColors.belyftedGreenColor.shade50,
        );
      case KycStatus.pending:
        return KycStats(
          label: 'Pending',
          textColor: AppColors.belyftedAmberColor.shade800,
          backgroundColor: AppColors.belyftedAmberColor.shade50,
        );
      case KycStatus.failed:
        return KycStats(
          label: 'Failed',
          textColor: AppColors.belyftedRedColor.shade700,
          backgroundColor: AppColors.belyftedRedColor.shade100,
        );
      case KycStatus.notStarted:
        return KycStats(
          label: 'Not Started',
          textColor: AppColors.belyftedNeutralColor.shade500,
          backgroundColor: AppColors.belyftedNeutralColor.shade200,
        );
    }
  }
}

class KycItem {
  const KycItem({
    required this.email,
    required this.role,
    required this.status,
    this.onResendLink,
  });
  final String email;
  final String role;
  final KycStatus status;
  final VoidCallback? onResendLink;
}
