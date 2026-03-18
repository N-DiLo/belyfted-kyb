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

class MockKYBData {
  static const List<String> businessTypes = [
    'Private Limited Company',
    'Public Limited Company',
    'Sole Trader',
    'Partnership',
  ];

  static const List<String> industries = [
    'Financial Services',
    'Technology',
    'Healthcare',
    'Retail',
    'Manufacturing',
  ];

  static const List<String> entities = ['Corporation', 'LLC', 'NGO', 'Trust'];

  static const List<String> countries = [
    'Nigeria',
    'Ghana',
    'Kenya',
    'South Africa',
    'United Kingdom',
  ];

  static const List<String> years = [
    '1 Year',
    '2 Years',
    '3 Years',
    '4 Years',
    '5 Years',
  ];

  static const List<String> scope = [
    'Logistics and delivery services',
    'Transportation services',
    'Procurement and supply of goods and materials',
    'Import and export services',
    'Warehousing and storage',
    'E-commerce support and order fulfillment',
    'Business support and administrative services',
    'Consultancy services in logistics and operations',
    'General trading of consumer goods and equipment',
    'Information and communication technology (ICT) services',
    'Marketing and advertising services',
    'Financial and agency services',
    'Training and capacity development',
    'Real estate and property services',
    'General contracts and services',
  ];

  static const List<String> roles = [
    'Provide strategic leadership',
    'Oversee company operations',
    'Ensure legal compliance',
    'Set company policies',
    'Manage financial decisions',
    'Supervise management team',
    'Represent the company',
    'Drive business growth',
    'Manage risks',
    'Monitor performance',
  ];

  static List<DirectorItem> get seedDirectors => const [
    DirectorItem(
      email: '',
      name: 'Kael Sharp',
      ownership: '50',
      shares: '',
      phone: '',
      address: '',
      role: 'Director',
    ),
  ];
  static VerificationResult get mockedResult => VerificationResult.verified;
}
