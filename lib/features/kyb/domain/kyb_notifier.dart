import 'package:belyfted/belyfted.dart';

class KYBSubmissionNotifier extends Notifier<KYBSubmissionState> {
  @override
  KYBSubmissionState build() => const KYBSubmissionState();

  void updateBusinessInfo({
    required String businessName,
    required String firstName,
    required String lastName,
    required String businessType,
    required String industry,
    required String entity,
    required String website,
    required String phone,
    required String email,
    required String address1,
    required String address2,
    required String city,
    required String stateValue,
    required String country,
    required String zipCode,
  }) {
    state = state.copyWith(
      businessName: businessName,
      firstName: firstName,
      lastName: lastName,
      businessType: businessType,
      industry: industry,
      entity: entity,
      website: website,
      phone: phone,
      email: email,
      address1: address1,
      address2: address2,
      city: city,
      state: stateValue,
      country: country,
      zipCode: zipCode,
    );
  }

  void updateRegInfo({required String taxID, required String businessDesc}) {
    state = state.copyWith(taxID: taxID, businessDesc: businessDesc);
  }

  void updateDirectors(List<DirectorItem> directors) {
    state = state.copyWith(directors: directors);
  }

  void updateUploadedFiles(Map<String, String> files) {
    state = state.copyWith(uploadedFiles: files);
  }

  void reset() => state = const KYBSubmissionState();
}

final kybSubmissionProvider =
    NotifierProvider<KYBSubmissionNotifier, KYBSubmissionState>(
      KYBSubmissionNotifier.new,
    );
