import 'package:belyfted/belyfted.dart';

class StartKYBView extends StatelessWidget {
  const StartKYBView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onLeadingIconTap: () {}),
      body: Padding(
        padding: po(r: 16, l: 16, t: 40, b: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  ImageWidget(url: AppImages.verify),
                  10.fhs,
                  TextWidget(
                    text: 'Verify Your Business',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    textColor: AppColors.belyftedNeutralColor.shade800,
                  ),
                  8.fhs,
                  TextWidget(
                    text:
                        'Unlock the full potential of your corporate finance. Secure, compliant, and global.',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    textColor: AppColors.belyftedNeutralColor.shade500,
                  ),
                ],
              ),
            ),
            45.fhs,
            Padding(
              padding: ps(h: 12.r),
              child: Row(
                children: [
                  Expanded(
                    child: FeatureCard(
                      image: AppImages.global,
                      title: 'Global Reach',
                      subtitle: 'Send to 180+ countries',
                    ),
                  ),
                  16.fws,
                  Expanded(
                    child: FeatureCard(
                      image: AppImages.zap,
                      title: 'Instant',
                      subtitle: 'Real-time processing',
                    ),
                  ),
                ],
              ),
            ),
            45.fhs,
            RequirementsCard(
              items: const [
                'Business Incorporation Certificate',
                'Memorandum & Articles of Association',
                'Director / UBO Identification Details',
                'Business Official Documents',
              ],
            ),
            Spacer(),

            Center(
              child: CustomButton(
                width: 378.fw,
                text: 'Start Verification',
                enabled: true,
                onTap: () async => navigations.pushNamed(RouteService.kybView),
              ),
            ),

            Padding(
              padding: ps(h: 9, v: 16),
              child: TextWidget(
                softWrap: true,
                textAlign: TextAlign.center,
                text:
                    'By continuing, you agree to our Terms of service and Privacy Policy.',
                textColor: AppColors.belyftedNeutralColor.shade500,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
