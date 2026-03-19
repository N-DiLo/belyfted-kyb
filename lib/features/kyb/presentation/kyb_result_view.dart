import 'package:belyfted/belyfted.dart';

class KYBResultView extends StatefulWidget {
  const KYBResultView({super.key, required this.option});
  final String option;

  @override
  State<KYBResultView> createState() => _KYBResultViewState();
}

class _KYBResultViewState extends State<KYBResultView> {
  late VerificationResult _result;

  @override
  void initState() {
    super.initState();
    _result = VerificationResultX.fromString(widget.option);
  }

  Future<void> _toggleResult() async {
    setState(() {
      _result = _result == VerificationResult.verified
          ? VerificationResult.failed
          : VerificationResult.verified;
    });
  }

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
              _result.useWrapper
                  ? VerificationImage(
                      shadowColor: AppColors.belyftedRedColor.shade800,
                      color: _result.color,
                      child: ImageWidget(url: _result.image),
                    )
                  : ImageWidget(url: _result.image),
              16.fhs,
              TextWidget(
                text: _result.title,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                textColor: AppColors.belyftedNeutralColor.shade800,
              ),
              16.fhs,
              TextWidget(
                softWrap: true,
                textAlign: TextAlign.center,
                text: _result.message,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textColor: AppColors.belyftedNeutralColor.shade500,
              ),
              45.fhs,
              CustomButton(
                onTap: _toggleResult,
                text: _result.buttonText,
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
