import 'package:belyfted/belyfted.dart';

class KYBSubmissionModel {
  const KYBSubmissionModel({
    required this.businessName,
    required this.firstName,
    required this.lastName,
    required this.businessType,
    required this.industry,
    required this.entity,
    required this.website,
    required this.phone,
    required this.email,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.taxID,
    required this.businessDesc,
    required this.directors,
    required this.uploadedFiles,
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
}
