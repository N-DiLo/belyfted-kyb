import 'package:belyfted/belyfted.dart';

class CheckStatusView extends StatelessWidget {
  const CheckStatusView({super.key, required this.submission});
  final KYBSubmissionModel submission;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: 16.pa,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VerificationImage(
                shadowColor: AppColors.belyftedAmberColor.shade500,
                color: AppColors.belyftedAmberColor.shade50,
                child: ImageWidget(url: AppImages.clock),
              ),
              16.fhs,
              TextWidget(
                text: 'Verifying Business Identity',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                textColor: AppColors.belyftedNeutralColor.shade800,
              ),
              16.fhs,
              TextWidget(
                softWrap: true,
                textAlign: TextAlign.center,
                text:
                    'We are currently reviewing your documents. Please note that all added directors must complete their KYC verification before your business can be approved.',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: AppColors.belyftedNeutralColor.shade500,
              ),
              53.fhs,
              KycCard(
                userType: submission.directors
                    .map(
                      (d) => KycItem(
                        email: d.email,
                        role: d.role,
                        status: KycStatus.pending,
                        onResendLink: () {},
                      ),
                    )
                    .toList(),
              ),

              45.fhs,
              CustomButton(
                onTap: () async {
                  navigations.pushReplacementNamed(
                    RouteService.verificationResult,
                    arguments: VerificationResult.verified.name,
                  );
                },
                text: 'Check Status',
                enabled: true,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                type: ButtonType.outline,
              ),
              16.fhs,
              TextWidget(
                text: 'Please refresh the status after 10 minutes',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: AppColors.belyftedNeutralColor.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
