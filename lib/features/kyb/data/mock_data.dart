import 'package:belyfted/belyfted.dart';

class MockKycData {
  static const List<KycItem> directors = [
    KycItem(
      email: 'Director1@company.com',
      role: 'Director',
      status: KycStatus.verified,
    ),
    KycItem(
      email: 'Director2@company.com',
      role: 'Shareholder',
      status: KycStatus.pending,
    ),
  ];
}
