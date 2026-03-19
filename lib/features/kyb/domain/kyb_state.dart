import 'package:belyfted/belyfted.dart';

class KYBSubmissionState {
  const KYBSubmissionState({
    this.businessName = '',
    this.firstName = '',
    this.lastName = '',
    this.businessType = '',
    this.industry = '',
    this.entity = '',
    this.website = '',
    this.phone = '',
    this.email = '',
    this.address1 = '',
    this.address2 = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.zipCode = '',
    this.taxID = '',
    this.businessDesc = '',
    this.directors = const [],
    this.uploadedFiles = const {},
  });

  final String businessName;
  final String firstName;
  final String lastName;
  final String businessType;
  final String industry;
  final String entity;
  final String website;
  final String phone;
  final String email;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final String taxID;
  final String businessDesc;
  final List<DirectorItem> directors;
  final Map<String, String> uploadedFiles;

  KYBSubmissionState copyWith({
    String? businessName,
    String? firstName,
    String? lastName,
    String? businessType,
    String? industry,
    String? entity,
    String? website,
    String? phone,
    String? email,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? country,
    String? zipCode,
    String? taxID,
    String? businessDesc,
    List<DirectorItem>? directors,
    Map<String, String>? uploadedFiles,
  }) {
    return KYBSubmissionState(
      businessName: businessName ?? this.businessName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      businessType: businessType ?? this.businessType,
      industry: industry ?? this.industry,
      entity: entity ?? this.entity,
      website: website ?? this.website,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      taxID: taxID ?? this.taxID,
      businessDesc: businessDesc ?? this.businessDesc,
      directors: directors ?? this.directors,
      uploadedFiles: uploadedFiles ?? this.uploadedFiles,
    );
  }

  KYBSubmissionModel toModel() => KYBSubmissionModel(
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
    state: state,
    country: country,
    zipCode: zipCode,
    taxID: taxID,
    businessDesc: businessDesc,
    directors: directors,
    uploadedFiles: uploadedFiles,
  );
}
