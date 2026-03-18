import 'package:belyfted/belyfted.dart';

class KYBResultView extends StatelessWidget {
  const KYBResultView({super.key, required this.option});
  final String option;

  @override
  Widget build(BuildContext context) {
    final result = VerificationResultX.fromString(option);

    return Scaffold(
      body: Padding(
        padding: 16.pa,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageWidget(url: result.image),
              16.fhs,
              TextWidget(
                text: result.title,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                textColor: AppColors.belyftedNeutralColor.shade800,
              ),
              16.fhs,
              TextWidget(
                softWrap: true,
                textAlign: TextAlign.center,
                text: result.message,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textColor: AppColors.belyftedNeutralColor.shade500,
              ),
              45.fhs,
              CustomButton(
                onTap: () async {},
                text: result.buttonText,
                enabled: true,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
