import 'package:belyfted/belyfted.dart';

enum VerificationResult { verified, failed }

extension VerificationResultX on VerificationResult {
  String get image {
    switch (this) {
      case VerificationResult.verified:
        return AppImages.vSuccess;
      case VerificationResult.failed:
        return AppImages.vFailed;
    }
  }

  String get title {
    switch (this) {
      case VerificationResult.verified:
        return 'Verified';
      case VerificationResult.failed:
        return 'Verification Failed';
    }
  }

  String get message {
    switch (this) {
      case VerificationResult.verified:
        return 'Your business account is now fully active';
      case VerificationResult.failed:
        return 'We couldn\'t verify your business information. Please ensure the documents are accurate and your uploads are not blurry.';
    }
  }

  String get buttonText {
    switch (this) {
      case VerificationResult.verified:
        return 'Continue';
      case VerificationResult.failed:
        return 'Try again';
    }
  }

  static VerificationResult fromString(String value) {
    return VerificationResult.values.firstWhere(
      (e) => e.name == value,
      orElse: () => VerificationResult.failed,
    );
  }
}
