import 'package:belyfted/belyfted.dart';

class CheckStatusView extends StatelessWidget {
  const CheckStatusView({super.key});

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
              ImageWidget(url: AppImages.vPending),
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
                userType: MockKycData.directors.map((item) {
                  return item.status == KycStatus.pending
                      ? KycItem(
                          email: item.email,
                          role: item.role,
                          status: item.status,
                          onResendLink: () {},
                        )
                      : item;
                }).toList(),
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
